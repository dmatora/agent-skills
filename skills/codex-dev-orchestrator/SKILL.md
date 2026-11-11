---
name: codex-dev-orchestrator
description: "Use for code or workflow changes, including bugs, features, refactors, and multi-step work. Skip consultations and review-only requests. Bypass only when the entire edit is clearly presentation-only (for example, display_name/short_description, copy, typos, or formatting) and leaves behavior, interfaces, requirements, and instructions unchanged; use this skill for mixed changes or any uncertainty."
---

# Codex Development Orchestrator

For a clearly presentation-only edit under the exception above, make the change directly without the Sol/Luna workflow.

The main orchestrator uses the model selected by the user. Delegate analysis and audit to GPT-6.1 Sol `xhigh`; delegate implementation and fixes to GPT-6 Luna `xhigh`. Use Luna `xhigh` for child task dialogues only when the user explicitly selected it for those chats or it is the verified default. A request for separate chats does not authorize a model override; if Luna `xhigh` cannot otherwise be assured, ask the user or report a blocker.

Before edits or implementation delegation, verify the target project is a Git repository. If not, stop and ask whether to initialize one or use an existing repository; do not edit code or start implementation chats without Git.

Use the current checkout by default. Choose a worktree when it materially reduces conflict or interference risk. Explain isolation in plain language; the user need not know or request the term “worktree.”

Use the current dialogue for one task. For multiple tasks, ask Sol to decompose the work and create one project dialogue per task only when the current request or a standing user instruction explicitly authorizes separate task chats; invoking this skill alone is not authorization. Follow the Sol → Luna → Sol loop, pass findings to Luna, and have Luna commit only after Sol accepts.

For scheduling, worktree use, and chat isolation, follow [references/workflow.md](references/workflow.md). Russian translations: [SKILL.ru.md](i18n/SKILL.ru.md) and [workflow.ru.md](i18n/workflow.ru.md). If a required model or task-chat tool is unavailable, report the blocker; do not silently substitute or combine tasks.
