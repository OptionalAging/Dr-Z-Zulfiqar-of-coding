# Optional Aging Platform

> Canonical agent instructions for the Optional Aging application repository. Human-facing documentation belongs in `README.md` and `docs/`.

## Project overview

Build a role-aware health-optimization platform for prospects, students, coaches, supervisors, clinicians when applicable, and administrators. The initial product is one Expo and React Native application with a Google Cloud API and PostgreSQL system of record.

## Architecture

- Client: Expo, React Native, TypeScript, Expo Router
- API: Google Cloud Run
- Identity: Firebase Authentication or Google Identity Platform
- Database: Google Cloud SQL for PostgreSQL
- Files: Google Cloud Storage
- AI: approved Vertex AI or other reviewed services
- Integrations: Fullscript first; other health-data sources only after review
- The client never connects directly to PostgreSQL.

## Operating principles

- Use the build-lean ladder: platform-native, existing dependency, then minimum new code.
- Trace all affected code paths before editing.
- Fix root causes in shared paths.
- Keep one source of truth for scoring, authorization, and domain rules.
- Preserve unrelated changes and keep diffs focused.
- Record meaningful architecture and data-model choices in `docs/decisions/`.
- Record open assumptions in `docs/common-ground.md`.

## Health-data safety

Invoke `health-data-safety` whenever work touches identity, medical history, biomarkers, laboratory data, uploads, AI processing, analytics, notifications, integrations, authorization, audit logs, exports, retention, or production infrastructure.

- Never commit PHI, real medical records, participant identifiers, access tokens, credentials, screenshots, or production data.
- Use synthetic fixtures by default.
- Never place health data or direct identifiers in URLs, analytics, push payloads, console logs, crash reports, traces, tickets, PR descriptions, or test snapshots.
- Authorize all participant-data access server-side using current role and relationship data.
- Apply minimum-necessary access and return only required fields.
- Use only approved services for the relevant data class; verify the exact product and contractual boundary.
- Do not claim HIPAA compliance from a code change. Report controls and evidence.

Read `docs/security/HEALTH-DATA-SECURITY.md` for the detailed control baseline.

## Clinical scope

- Coaches support education, adherence, behavior change, prioritization, and navigation within approved protocols.
- Coaches do not diagnose or prescribe.
- AI may organize information and draft proposals; required human review occurs before publication.
- Medication content must direct the participant to a licensed clinician for prescribing decisions.
- Preserve distinct states for AI proposal, coach draft, required review, published plan, and superseded plan.

Read `docs/security/CLINICAL-SCOPE.md` for detailed boundaries.

## Domain invariants

- Completed assessments are immutable; corrections and reassessments create linked sessions.
- Preserve assessment, question, scoring, and bottleneck-rule versions.
- Preserve actual observation dates separately from entry, result, import, and verification dates.
- Preserve source provenance and verification status.
- Keep system recommendation, coach approval, participant action, and outcome separate.
- Never recategorize real participant data as synthetic merely because it is not the official baseline.

## Commands

Fill these in after the application is scaffolded:

```bash
# install:
# run development:
# lint:
# typecheck:
# unit tests:
# integration tests:
# web export/build:
# preview build:
```

## Verification

A change is complete only when fresh evidence supports the claim. Run the focused checks and the broadest affordable integration check. For health-data work, include negative authorization tests, prohibited-data log review, and audit-event verification.

## Cross-agent review

Invoke `cross-agent-review` before approving or merging consequential changes involving authentication, authorization, PHI or health data, clinical workflows, database migrations, production infrastructure, destructive operations, public contracts, payments, security controls, or expensive architecture decisions.

- The implementation author and reviewer must use different agent contexts.
- The first review pass is read-only and inspects the actual diff and affected paths.
- Findings require severity, evidence, and a concrete correction.
- The implementation agent remediates confirmed findings; the independent reviewer re-verifies them.
- PASS requires fresh verification against the reviewed commit SHA.
- Human approval is required when BLOCKER or HIGH findings remain or a regulated boundary is unresolved.

## Git and pull requests

- Branch prefixes: `feat/`, `fix/`, `docs/`, or `chore/` plus a short slug.
- Do not work directly on the default branch after repository bootstrap.
- Keep commits focused and explain why.
- Run secret scanning before every push.
- Open draft pull requests until validation and review are complete.

## Ask first

- Authentication or authorization model changes
- Database migrations affecting participant or health data
- New vendors or external data transfers
- Logging, analytics, exports, retention, deletion, or backup changes
- Clinical-scope or escalation changes
- Destructive operations or production configuration

## Never

- Commit secrets, `.env` files, PHI, or real-person test data
- Bypass authorization because a screen is hidden
- Force-push the default branch
- Silently rewrite completed assessments or source observations
- Publish an unreviewed AI clinical plan
- Enable unrestricted agent access in an environment containing production credentials

## Project learnings

<!-- Append one concise line per durable correction. Newest last. -->
