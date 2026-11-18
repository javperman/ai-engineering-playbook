# AGENTS.md — contract template

Copy this file into a repository and adapt the placeholders. Keep it short enough
that a human and an agent can read it before starting work.

## Mission

Describe the product in two or three sentences. State who uses it and what
"working" means.

## Source of truth

1. `<primary artifact>` is the source of truth.
2. The system is rebuilt from it; do not edit generated output backwards.
3. Every change that affects behavior is recorded in `<changelog or ADR>`.

## Hard rules

- Never modify original inputs; work on copies and verify hashes.
- Do not send private data to an external service without explicit approval.
- Do not expose local tools outside `127.0.0.1`.
- Do not commit secrets, credentials, tokens, private keys or `.env` files.
- Do not install global dependencies when an isolated environment exists.
- Do not delete or weaken a test to make a change pass.
- Document every limitation and every check that was not run.

## Honesty about capabilities

- Check whether the requested operation is supported before applying it.
- If it is not supported, say so explicitly and propose alternatives.
- Never claim a test, render or integration works if it was not executed.
- "It cannot be done" is a valid answer.

## Verification

- The definition of done is: `<command>` passes and `<artifact>` is inspected.
- A check that only starts the app is not a pass.
- Hardware-dependent checks are marked; skip only when the hardware is absent.
- Attach the commands and the observed result to the change.

## Review

- Keep diffs small and scoped.
- Call out interface changes, new dependencies, migrations and data changes.
- Do not mix refactors, formatting and behavior changes in one commit.

## Secrets and PII

- Scan tracked files before committing: `<scan command>`.
- Use a public commit identity: `<name> <noreply address>`.
- If a secret is exposed, stop, rotate it, and write an incident note.

## Handoff

At the end of every iteration:

1. Update the status document with what changed.
2. Record what was tested, the commands and the limitations.
3. List the next action and any decision needed from a human.
4. Leave the working tree clean.
