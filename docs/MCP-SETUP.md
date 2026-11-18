# MCP setup

MCP servers give an agent tools outside the chat: files, browsers, databases,
issue trackers. The default should be least privilege and local-only.

## Principles

1. **Local by default.** Bind to `127.0.0.1`, not `0.0.0.0`.
2. **One token, one scope.** Do not reuse a personal token for an agent.
3. **Read-only first.** Add write tools only when the task needs them.
4. **No secrets in config.** Read tokens from the environment or a keyring.
5. **Log tool calls.** Keep enough to audit, not enough to leak data.
6. **Revoke at the end.** A temporary token is temporary.

## Minimal config

```jsonc
{
  "mcpServers": {
    "local-tools": {
      "command": "your-mcp-server",
      "args": ["--transport", "stdio"],
      "env": {
        "LOG_LEVEL": "info"
      }
    }
  }
}
```

Do not put `API_KEY`, `TOKEN` or a database URL in this file. The server should
read them from the environment.

## Permissions

- Filesystem: scope to the project directory; no home directory by default.
- Shell: allowlist the commands the task needs; no blanket `sudo`.
- Browser: local profile; no saved passwords; no production admin session.
- Database: read-only replica or a disposable local database for exploration.
- Git: no force-push, no visibility changes, no collaborator changes.

## Audit

- Who started the server?
- Which directories and networks can it reach?
- Which tools are write-capable?
- Where are the logs?
- When is the token revoked?

## If something goes wrong

1. Stop the server.
2. Revoke the token.
3. Check the logs for what was read or written.
4. Rotate any credential that was reachable.
5. Write a short incident note with the timeline and the fix.

## Anti-patterns

- A global MCP server with a personal token.
- A database tool with production write access.
- A browser profile with saved passwords.
- A token in a committed `.mcp.json` or `settings.local.json`.
- "It is only localhost" with no authentication on a shared machine.
