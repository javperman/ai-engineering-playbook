# Secret hygiene

Assume a secret will eventually be pasted in the wrong place. The goal is to
make that mistake visible before it reaches a public repository.

## Threat model

- A `.env` file is tracked because it was added before `.gitignore`.
- A token is pasted into a config, a test fixture or a screenshot.
- A private key is committed in a service-account JSON.
- A token is in a URL, a notebook output or a log.
- A commit identity exposes a personal email.
- A secret is removed in a later commit but remains in history.

## Scan before every push

```bash
# Tracked content (including files that are in .gitignore but still tracked)
./scripts/check-no-secrets.sh

# Working tree, including hidden files and ignored files
rg --hidden --no-ignore -n -e 'AIza[0-9A-Za-z_-]{20,}' \
  -e 'sk-[A-Za-z0-9]{20,}' -e 'ghp_[A-Za-z0-9]{20,}' \
  -e 'xox[baprs]-' -e '-----BEGIN [A-Z ]*PRIVATE KEY' .
```

`git grep` is the right tool for tracked content: it ignores `.gitignore` and
searches what a clone would receive.

## File names to inspect

- `.env`, `.env.*`, `.npmrc`, `.pypirc`, `pip.conf`
- `credentials*.json`, `*service-account*.json`, `*.pem`, `*.key`, `*.p12`,
  `*.jks`, `*.pfx`, `id_rsa`, `id_ed25519`
- `mcp-token`, `secrets.*`, `backup*.sql`, `*.dump`
- `.claude/`, `.vscode/`, `.opencode/` files that may contain local paths

## Commit identity

A commit records the author email forever. For public repositories, set a public
identity per repository:

```bash
git config user.name "Your Name"
git config user.email "you@users.noreply.github.com"
```

Do not rely on the global config. Check the first commit before pushing:

```bash
git log --format='%an <%ae>%n%cn <%ce>'
```

## Fresh history for public releases

If the private history contains secrets, do not publish it and rely on a later
removal. Export only the tracked tree, start a new repository and commit once:

```bash
git archive HEAD | tar -x -C /path/to/public-staging
cd /path/to/public-staging
git init -b main
git add .
git commit -m "Initial public release"
```

Then scan the new repository, including every blob:

```bash
git grep -I -n -E '<patterns>' $(git rev-list --all)
git fsck --unreachable
```

## Pre-push hook

A local hook is a last line of defense, not a substitute for review:

```bash
#!/usr/bin/env bash
set -euo pipefail
./scripts/check-no-secrets.sh
```

Install it as `.git/hooks/pre-push` and make it executable. Do not commit the
hook as a file that contains local paths; keep the scanner in the repository and
the hook thin.

## If a secret was exposed

1. Stop. Do not `git push --force` and hope.
2. Rotate the credential immediately.
3. Remove the secret from the working tree and from tracking.
4. If it was pushed, delete the repository or rewrite history only with a clear
   plan; assume the old object is still reachable.
5. Check logs for use of the credential.
6. Write an incident note: what, when, where, impact, rotation, prevention.

## Limits

- Regex scanners miss custom formats and encoded secrets.
- Entropy scanners produce false positives in lockfiles and minified code.
- Image metadata and screenshots need a human review.
- A clean scan is evidence, not proof.

## Checklist

- [ ] `check-no-secrets.sh` passes.
- [ ] No sensitive filenames are tracked.
- [ ] The commit identity is public.
- [ ] The history is fresh or audited.
- [ ] The pre-push hook is installed.
- [ ] A second clone was scanned.
- [ ] Any exposed credential was rotated.
