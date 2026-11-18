# Plan template

A plan is a sequence of phases with evidence and gates. It is not a wish list.

## Phase format

```markdown
## Phase N — <name>

### Objective
<one sentence>

### Inputs
- <files, decisions, access>

### Outputs
- <artifacts, reports, commits>

### Commands
```bash
<exact commands>
```

### Evidence
- <test output, screenshot, benchmark, URL, hash>

### Gate
- [ ] <criterion 1>
- [ ] <criterion 2>

### Stop conditions
- <what forces a stop and a question>

### Status
GO / NO-GO
```

## Rules

1. One phase, one objective. If the objective needs an "and", split it.
2. Every phase writes a report: objective, commands, findings, files, checks,
   pending items, gate status.
3. A gate is binary. "Mostly done" is not a gate.
4. If a plan assumption is false, stop and report. Do not silently change scope.
5. Decisions that are not in the plan require a human decision, not a guess.
6. Evidence is a command output, a file path, a URL or a hash. "It works" is not
   evidence.
7. The final phase is verification by a stranger: fresh clone, fresh environment,
   no local state.

## Decision log

| ID | Decision | Options | Chosen | Date | Owner |
|---|---|---|---|---|---|
| D1 | <topic> | A / B / C | <choice> | <date> | <person> |

## Report template

```markdown
# Phase N — <name>

## Objective
## Commands executed
## Findings
## Files created or modified
## Checks and evidence
## Pending and questions
## Gate status: GO / NO-GO
```

## Anti-patterns

- A phase with no gate.
- A gate that can be satisfied by reading the diff only.
- A plan that changes after the work starts without recording the change.
- A report that says "tests pass" without the command and the count.
- A "temporary" secret, fixture or script that is never removed.
