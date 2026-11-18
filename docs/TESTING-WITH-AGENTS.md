# Testing with agents

An agent can write a test that passes without proving anything. The review must
check what the test actually does.

## Test levels

1. **Unit:** pure functions, parsers, validators, state machines.
2. **Contract:** adapters against a fake or a recorded fixture.
3. **Integration:** real files, real database, real process boundaries.
4. **End-to-end:** the product action a user actually performs.
5. **Manual/visual:** only for what cannot be asserted automatically.

## Rules

- A test that only starts the app is not an end-to-end test.
- The test must fail before the fix and pass after it, or the reason must be
  documented.
- Assert observable behavior, not implementation details.
- Do not mock the thing you are trying to verify.
- Do not use a real secret, customer record or production endpoint in a test.
- Fixtures with fake keys must be obviously fake and must not match a real key
  format.
- Hardware-dependent tests are skipped only when the hardware is absent; the skip
  reason is printed.
- Flaky tests are quarantined with an owner and a date, not silently retried.

## What to ask the agent

- What command did you run?
- What was the exact output?
- Which test would fail if the change were reverted?
- Which part is not covered, and why?
- Which checks require hardware, network or a model that is not available?

## What to run yourself

- The full relevant suite.
- The end-to-end command on a small fixture.
- The linter/type checker, if the project has one.
- A clean install in a fresh environment, when dependencies changed.

## Test data

- No real names, emails, phone numbers, tokens or customer records.
- No production database dump.
- No screenshots with personal data.
- Use synthetic fixtures and document their origin.

## CI

- Pin the toolchain.
- Run the same command locally and in CI.
- Fail on a secret-scan hit.
- Keep a short, readable log; do not print environment variables.

## Definition of done

```text
[ ] The command was run.
[ ] The output is attached.
[ ] The failure mode is covered.
[ ] The limitation is documented.
[ ] A human reviewed the diff.
```
