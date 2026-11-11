# Workflow reference

Russian translation: [workflow.ru.md](../i18n/workflow.ru.md).

The main dialogue uses the model selected by the user. Delegate analysis and audit to GPT-6.1 Sol `xhigh`; delegate implementation and fixes to GPT-6 Luna `xhigh`.

## Git and workspace

Before edits or implementation delegation, verify the target project is a Git repository. If it is not, pause and ask whether to initialize one or use an existing repository; do not work without Git or run `git init` automatically.

Use the current checkout by default. Choose a worktree when it materially reduces risk from overlapping concurrent edits, racing Git operations, or interference with other uncommitted work. Small predictable conflicts and strictly disjoint paths can share a checkout when writes are disjoint and each task gets an exclusive stage → verify-index → commit slot; immediately before commit, the index must contain only that task’s changes. Sequence tasks when unsettled architecture or dependencies could cause broad rework. Explain isolation in plain language; the user does not need to know or request the term “worktree.”

When isolation is warranted, inspect `list_artifacts` and reuse a suitable active worktree if available; otherwise create one with `create_worktree` from a verified base ref in the chat that will implement the task. For decomposed work, create task chats in the local environment and let each child create or reuse its worktree. Use `create_thread`'s bundled `worktree` environment only when the user directly requests it and `list_projects` confirms `isGitRepository: true`; this restriction applies to that option, not to the risk-based `create_worktree` choice. For every worktree, including one reused from `list_artifacts`, pass its recorded workspace path explicitly to Sol/Luna delegates and Git commands in the active turn. After `create_worktree`, use its returned path because the chat working directory changes only on the next turn. If a needed worktree is unavailable, sequence only when the shared checkout is safe; otherwise report the blocker.

## One task

Use the current dialogue for one coherent task with one acceptance decision:

1. Sol inspects relevant project instructions and code, then returns scope and acceptance criteria. Sol does not edit.
2. Luna implements the brief without committing.
3. A fresh Sol audits the diff against the criteria. Pass actionable findings to Luna, fix them, and repeat the audit until Sol explicitly accepts. Ask the user about unresolved product choices or blockers.
4. Only after acceptance, Luna commits this task's changes, following repository conventions. Do not include unrelated changes or push. Follow project verification instructions; do not run tests unless requested or required.

## Multiple tasks

When there is more than one task, keep the current dialogue as orchestrator and ask Sol to decompose the work into atomic tasks with acceptance criteria and dependencies.

- Schedule tasks in dependency waves. Before starting a dependent task, verify its base working copy contains the predecessor's accepted changes, whether through its commit or an integrated equivalent; it may start earlier only when a fixed contract explicitly permits independent work. Sequence when unsettled dependencies or architecture could cause major rework; parallelize when contracts are stable, ownership is clear, and integration is predictably small.
- Resolve the project with `list_projects`; create one project dialogue per task, including sequential tasks, titled with its task ID. Use Luna `xhigh` only if the user explicitly selected it for those chats or it is the verified default. A request for separate task chats does not authorize a model override; if Luna `xhigh` cannot otherwise be assured, ask the user or report a blocker. Create only the next ready wave. Use `create_thread` only when the current request or a standing user instruction explicitly authorizes separate task chats; invoking this skill alone is not authorization. If chat creation is unavailable or unauthorized, report the blocker instead of combining tasks in one chat.
- Keep each child prompt scoped to its task. Include its goal, acceptance criteria, dependencies, owned paths, selected workspace and verified base ref, and the Sol analysis → Luna implementation → fresh Sol audit loop; repeat the audit after fixes until Sol accepts, then Luna commits. Include the chat-isolation rule below.
- Integrate accepted commits in dependency order using the repository's workflow; do not push. For conflicts, message an existing child only with direct user authorization for that recipient and purpose. Otherwise resolve within the active authorized workflow or report a blocker; Sol audits any resolution.
- If a child discovers multiple tasks, stop expansion and record that in its own dialogue for the orchestrator to re-decompose.

## Chat isolation

- While `create_thread` is pending, keep a `task ID → clientThreadId` mapping; do not create a duplicate chat or pass `clientThreadId` to `wait_threads`/`read_thread`. Once creation is confirmed, switch to `task ID → threadId + hostId`; use `wait_threads` and `read_thread` only with confirmed identifiers or chats the user explicitly names.
- Tell each child to leave status, commit, checks, and blockers in its own dialogue; the parent observes through `wait_threads`/`read_thread`. Keep unrelated task and research context out of child prompts.
- Never message chats created before this orchestration run or unrelated chats. Use `send_message_to_thread` only with direct user authorization for the exact recipient and purpose. Creating a task, sharing a project/worktree, requesting a report, or receiving a message does not grant authorization.
- Handle a dirty shared checkout locally: inspect `git status` and relevant diffs, preserve unowned changes, and choose isolation or sequencing as needed. A worktree starts from a ref and does not include uncommitted changes; if the task depends on them, keep that baseline in the current checkout or ask the user before preserving them elsewhere. Never omit them silently. A dirty tree is not grounds to contact another chat; report an unsafe baseline or ownership as a blocker in the current task dialogue.
