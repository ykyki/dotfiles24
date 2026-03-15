# CLAUDE.md

## User Interaction Language

- Always respond in Japanese.

## GitHub Operations
When performing ANY GitHub operations via `gh` CLI that involve writing
comments or creating content (including but not limited to: PR comments,
Issue comments, PR creation, Issue creation, review comments, etc.),
ALWAYS append the following signature at the end of the message body:

```
---
🤖 Generated with Claude Code
```

## Preferred Commands

When running shell commands, follow these preferences:

- Use `jq` (never `python`) to read and query JSON files.

