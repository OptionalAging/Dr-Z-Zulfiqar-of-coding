---
name: cross-agent-review
description: Orchestrate independent review of consequential code, architecture, data, security, privacy, clinical, migration, release, or infrastructure work. Use when one agent has implemented or recommended a load-bearing change and a fresh agent must audit it without inheriting the author's reasoning. Enforce author-reviewer separation, read-only first pass, evidence-backed severity findings, independent verification, remediation by the implementer, re-review, and human-controlled merge. Invoke automatically for authentication, authorization, PHI or health data, payments, destructive operations, public contracts, production releases, database migrations, or other high-blast-radius changes.
---

# Cross-Agent Review

Run an independent, adversarial review before a consequential change is approved or merged. Preserve genuine separation between the implementation context and the review context.

## Review gate

Require cross-agent review for:

- authentication, authorization, permissions, tenant isolation, or identity
- PHI, health data, medical history, biomarkers, uploads, AI processing, clinical workflows, or vendor transfers
- database migrations, destructive operations, retention, deletion, backup, or recovery
- payments, billing, money movement, public APIs, external contracts, or irreversible actions
- production releases, infrastructure, secrets, security controls, concurrency, or data-loss risk
- architecture or schema choices that are expensive to reverse

Use judgment for low-risk, reversible changes. Do not turn trivial formatting or documentation edits into a ceremony.

## 1. Freeze the implementation packet

Before review, record:

- repository, branch, pull request, and commit SHA
- original requirement and acceptance criteria
- affected paths and interfaces
- checks already run, with exact results
- known limitations and anything not verified

Do not include the author's private reasoning, preferred verdict, or persuasive summary. Give the reviewer primary sources and a neutral task statement.

## 2. Create an independent reviewer context

Use a fresh task, fresh agent, separate worktree, or separate model. The reviewer must not be the implementation author and must not inherit the author's chat history.

Preferred order:

1. fresh read-only reviewer agent against the pull request or commit
2. different model or provider when available for stronger decorrelation
3. GitHub review agent such as `@codex review`
4. human reviewer who did not participate in the implementation

A second message in the author's existing context is not independent review.

## 3. Perform a read-only first pass

The reviewer must not modify code during the first pass. It must:

- read the requirement, diff, and affected code paths
- inspect tests and execute relevant checks independently
- look for missing requirements, regressions, unsafe assumptions, duplicated sources of truth, unnecessary complexity, and failure modes
- test negative paths, boundary conditions, and authorization failures
- invoke `health-data-safety` for identity or health-data work
- invoke `verification-before-completion` before any PASS claim
- invoke `systematic-debugging` when a failure or inconsistent result appears

The reviewer starts from a skeptical posture. It may return PASS only when the change survives active attempts to falsify it.

## 4. Report findings with evidence

Classify each finding:

- **BLOCKER**: credible risk of unauthorized access, PHI exposure, data loss, unsafe clinical behavior, broken production behavior, or an unmet essential requirement
- **HIGH**: serious defect or security/reliability gap that should be fixed before merge
- **MEDIUM**: material maintainability, correctness, observability, or edge-case problem
- **LOW**: useful improvement that does not block merge

Each finding must include:

- severity
- file and line or exact affected component
- failure mechanism
- evidence or reproduction
- smallest appropriate correction
- confidence and what would change the assessment

Do not report style preferences as defects. Do not dilute severe findings with large lists of speculative concerns.

## 5. Separate remediation from review

Return confirmed findings to the implementation agent. The implementation agent may fix them in the existing branch, add regression tests, and update the pull request.

The original reviewer then performs a re-review. It must verify:

- every prior finding is resolved or explicitly accepted by the human owner
- remediation did not introduce new regressions
- the final commit SHA and checks match the reviewed state

The implementer cannot mark its own findings resolved without independent verification.

## 6. Control merge authority

Agents may recommend a merge decision but do not merge high-risk work unless the user has explicitly authorized automated merging for that repository and change class.

Require human approval when any of these apply:

- BLOCKER or HIGH findings remain
- PHI boundary, vendor approval, BAA status, or clinical-review requirement is unresolved
- destructive migration or production data change
- security control is weakened or bypassed
- reviewer could not execute a load-bearing verification

## Output contract

Return:

```text
REVIEW TARGET
<repository, PR, branch, commit>

REQUIREMENTS CHECK
<met, unmet, or not verifiable>

FINDINGS
[SEVERITY] file:line - concise title
Failure: <mechanism>
Evidence: <reproduction, test, or source>
Correction: <smallest appropriate fix>
Confidence: <high|medium|low and why>

VERIFICATION
<commands or checks independently run and results>

UNVERIFIED
<what could not be checked>

FINAL VERDICT
PASS | PASS WITH NON-BLOCKING FINDINGS | FAIL

MERGE RECOMMENDATION
MERGE | HOLD | HUMAN DECISION REQUIRED
```

Read `references/review-contract.md` for ready-to-use implementation, first-review, remediation, and re-review prompts.

## Hard rules

- Author and reviewer must be different contexts.
- First review is read-only.
- Evidence outranks agent confidence.
- A reviewer must inspect the actual artifact, not only the PR description.
- PASS requires fresh verification against the reviewed commit.
- Unresolved high-risk uncertainty produces HOLD, not a guessed approval.
- Review findings inform the human owner; they do not silently authorize execution or merge.
