# Review checklist

Use this for every agent-generated diff that can affect production, data,
security or a public interface.

## Scope

- [ ] The diff does only what the task asked.
- [ ] No unrelated formatting or refactor noise.
- [ ] No new public interface, dependency, migration or data field without an
      explicit decision.
- [ ] Generated files, lockfiles and vendored code are intentional.

## Correctness

- [ ] The change is consistent with the source of truth.
- [ ] Error paths are handled, not only the happy path.
- [ ] Idempotency, retries and ordering are considered where relevant.
- [ ] Inputs are validated at the boundary.
- [ ] The change does not silently change behavior outside the task.

## Tests

- [ ] A test exists for the new behavior.
- [ ] The test fails without the change (or the reason is explained).
- [ ] The full relevant suite was run, not only the new test.
- [ ] Hardware-dependent tests are marked and the skip reason is explicit.
- [ ] No test was deleted, weakened or marked skip to make the change pass.
- [ ] The command and result are attached to the review.

## Security and privacy

- [ ] No secrets, tokens, private keys, cookies or `.env` values.
- [ ] No PII in code, tests, fixtures, logs, screenshots or commit messages.
- [ ] No customer names, internal hostnames, project IDs or account IDs.
- [ ] Auth and authorization checks are on the server side.
- [ ] Logs do not contain personal data or credentials.
- [ ] Dependencies are necessary and their licenses are compatible.

## Operations

- [ ] Migrations are versioned, reversible and tested on a copy.
- [ ] Rollback is possible without editing production data by hand.
- [ ] Configuration changes are documented.
- [ ] Monitoring/alerting is not weakened.
- [ ] A failure does not leave a half-written state.

## Documentation

- [ ] README/docs match the new behavior.
- [ ] The limitation is written down.
- [ ] The changelog/ADR records the decision and the evidence.
- [ ] No claim is made that the evidence does not support.

## Git

- [ ] The commit identity is public and intentional.
- [ ] The commit message describes the change, not the agent's process.
- [ ] No secret is in the history, including uncommitted/dangling objects.
- [ ] The branch has no unexpected remote.
- [ ] The tree is clean after the commit.

## Stop signs

Stop and ask if:

- a secret or personal data appears and cannot be removed with certainty;
- a test cannot be run and the result is being described as if it ran;
- the change requires a public interface or data migration decision;
- the license of a dependency or asset is unclear;
- the diff cannot be reviewed in one sitting;
- the task requires production access, credentials or customer data.
