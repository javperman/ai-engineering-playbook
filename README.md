# AI Engineering Playbook

How I build software with coding agents without giving up engineering discipline.

This is not a prompt collection. It is the operating system around the agent:
a contract, a plan with gates, tests as a safety net, human review of the diff,
and a secret-hygiene routine that assumes the agent will eventually make a
mistake.

[Español](README.es.md) · [Português](README.pt.md) · [日本語](README.ja.md)

---

## The problem

Coding agents are fast and confident. That combination is dangerous when the
task touches production, personal data, credentials or customer code.

The failure modes I design for:

- the agent claims a test passed when it only started the app;
- a plan silently changes scope mid-implementation;
- a secret ends up in a commit, a fixture or a screenshot;
- a "small refactor" rewrites a public interface;
- the diff is too large to review, so nobody reviews it;
- the agent's context is lost and the next session repeats the same mistakes.

## The method

### 1. A contract: `AGENTS.md`

The repository has a written contract for agents: mission, source of truth,
invariants, forbidden actions, verification requirements and definition of done.
It is short enough to read and specific enough to enforce.

Template: [`templates/AGENTS.md`](templates/AGENTS.md)

### 2. A plan with gates

Work is split into phases. Each phase has an objective, a report, evidence and a
gate. If a phase cannot meet its gate, it stops and asks instead of improvising.

Template: [`docs/PLAN-TEMPLATE.md`](docs/PLAN-TEMPLATE.md)

### 3. Tests as a safety net

A test that only starts the app is not a pass. Tests must import, edit, save,
reopen and render when the product does that. Hardware-dependent checks are
marked and skipped only when the hardware is genuinely absent.

Guide: [`docs/TESTING-WITH-AGENTS.md`](docs/TESTING-WITH-AGENTS.md)

### 4. Human review of the diff

The agent proposes; the human accepts. The review looks for scope creep, silent
interface changes, removed tests, new dependencies, secrets, PII and misleading
docs.

Checklist: [`docs/REVIEW-CHECKLIST.md`](docs/REVIEW-CHECKLIST.md)

### 5. Secret hygiene

Assume a secret will eventually be pasted somewhere. Design so it does not reach
the repository:

- scan tracked files, not just the working tree;
- scan hidden files and tracked-but-ignored files;
- set a public commit identity;
- use fresh Git history for public releases;
- run a pre-push check that fails closed;
- rotate anything that was ever exposed.

Guide: [`docs/SECRET-HYGIENE.md`](docs/SECRET-HYGIENE.md)  
Script: [`scripts/check-no-secrets.sh`](scripts/check-no-secrets.sh)

### 6. MCP and local tools

MCP servers are powerful and easy to over-permission. Bind them to localhost,
scope tokens, log tool calls and never put a token in a config file that can be
committed.

Guide: [`docs/MCP-SETUP.md`](docs/MCP-SETUP.md)

---

## What is in this repository

```text
templates/AGENTS.md          contract template for a repository
docs/PLAN-TEMPLATE.md        phased plan with gates and evidence
docs/REVIEW-CHECKLIST.md     human review checklist
docs/TESTING-WITH-AGENTS.md  testing strategy for agent-written code
docs/MCP-SETUP.md            local MCP setup and permissions
docs/SECRET-HYGIENE.md       scanning, commit identity, incident response
scripts/check-no-secrets.sh  a small, dependency-free scanner
```

## What this is not

- Not a list of magic prompts.
- Not a claim that agents can replace review.
- Not a guarantee that a scan finds every secret.
- Not tied to one vendor; the examples use generic tools.

## Who it is for

Engineers using coding agents on real repositories, especially when the work
touches production systems, personal data or client code.

## License

CC BY 4.0. See [`LICENSE`](LICENSE).
