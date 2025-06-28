# CLAUDE.md

## Task Documentation Requirements

**CRITICAL**: Claude Code MUST create a comprehensive task summary document in the `.ykyki/claude/` directory upon:
- Task completion
- Task interruption
- Context switching
- Session termination

**Documentation Language**:
Write in Japanese.

**Directory creation**:
If `.ykyki/claude/` doesn't exist, create it with `mkdir -p .ykyki/claude`

### File Naming Convention
Format: `YYMMDD_HHMM-{task-description}.md`
- Use JST timestamp
- Replace spaces with hyphens in task description
- Keep description concise (3-5 words)

### Required Document Structure

**Required structure** (in Japanese):
- **Context** - Background information and task rationale. Include:
    - Why this task was initiated
    - Related project context
    - Dependencies or prerequisites
- **Prompt** - Exact user prompts.
- **Plan** - Execution plan to accomplish the task.
- **Do** - Logs of operations, rationales and decisions.
- **Result** - Outcomes, Unresolved issues, and next steps.

**Example format**:
```markdown
# Task: {Brief Title}

## Context
タスクの背景...

## Prompt
ユーザの元のプロンプト...

## Plan
実行計画...

## Do
実行内容...

## Result
結果...
```

