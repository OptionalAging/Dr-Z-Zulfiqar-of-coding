# Cross-Agent Review Contracts

## Implementation task

```text
Implement {{requirement}} in {{repository}}.

Follow AGENTS.md and invoke all relevant project skills. Create a feature branch, implement the smallest complete solution, run the required checks, and open a pull request.

Record the requirement, acceptance criteria, affected paths, exact checks and results, limitations, and anything not verified. Do not merge the pull request.
```

## Independent first review

```text
Perform an independent adversarial review of {{repository}} PR #{{number}} at commit {{sha}}.

You did not author this work. Do not rely on the author's reasoning or PR summary as evidence. Read the original requirement, complete diff, affected code paths, tests, and relevant project instructions directly.

The first pass is read-only. Do not modify files.

Actively try to falsify correctness. Inspect requirements coverage, regressions, boundary conditions, negative paths, authorization, data exposure, logging, audit behavior, failure handling, unnecessary complexity, and duplicate sources of truth. Invoke health-data-safety for identity or health-data work, verification-before-completion before PASS, and systematic-debugging for failures.

Report evidence-backed findings using the cross-agent-review output contract. PASS only if no blocking or high-severity finding remains and fresh verification supports the reviewed commit. State everything not verified.
```

## Remediation task

```text
Address the confirmed findings from the independent review of PR #{{number}}.

Verify each finding before editing. Make focused corrections, preserve unrelated work, add regression tests where appropriate, rerun the relevant verification, and update the existing pull request. Do not merge. Record the new commit SHA and exact test results for re-review.
```

## Re-review task

```text
Re-review PR #{{number}} at commit {{new_sha}} after remediation.

Remain read-only. Verify each prior finding against the actual code and test output, inspect the remediation diff for new defects, and rerun the relevant checks. Return resolved, unresolved, and newly introduced findings, followed by the final verdict and merge recommendation. Do not treat the implementer's statement that a finding is fixed as proof.
```

## GitHub comment fallback

```text
@codex review this PR independently for requirement coverage, regressions, authorization, tenant isolation, health-data or PHI leakage, unsafe logging, audit behavior, failure modes, and missing negative tests. Treat the first pass as read-only and cite evidence for each finding.
```
