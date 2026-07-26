# Optional Aging Threat Model

Status: living document
Last reviewed: TODO
Owner: TODO

## System scope

Document the exact application, environment, services, and workflows included. Link the current architecture diagram and `PHI-DATA-FLOW.md`.

## Protected assets

- participant identity and contact information
- medical history, medications, allergies, laboratory results, and uploaded records
- assessment responses and scores
- coach notes and intervention plans
- authentication credentials and sessions
- integration credentials and refresh tokens
- audit records
- proprietary protocols and scoring logic

## Actors and trust boundaries

- anonymous prospect
- participant/student
- assigned coach
- supervisor
- clinician when applicable
- support and administrator
- application services
- vendors and integrations
- malicious external actor
- compromised or careless authorized user
- untrusted uploaded content

## High-priority threats

| Threat | Example | Primary controls | Required evidence | Residual risk | Owner |
|---|---|---|---|---|---|
| Broken object authorization | Participant or coach changes an ID to access another record | Server-side relationship checks, negative tests, audits | Integration tests | TODO | TODO |
| Privilege escalation | Coach gains supervisor or administrator access | Role assignment controls, MFA, audit, separation of duties | Authorization tests and access review | TODO | TODO |
| Sensitive-data leakage | PHI appears in logs, analytics, URLs, notifications, screenshots | Data minimization, redaction, safe event schemas, review | Log and telemetry inspection | TODO | TODO |
| Account takeover | Credential theft or recovery abuse | MFA, secure recovery, rate limits, session revocation | Auth tests and monitoring | TODO | TODO |
| Malicious upload | Malware, path traversal, archive bomb, prompt injection | Validation, isolation, scanning, size limits, untrusted-content handling | Upload security tests | TODO | TODO |
| AI extraction error | Wrong biomarker, date, units, or medication | Provenance, structured validation, confidence, human confirmation | Golden-set tests and review | TODO | TODO |
| AI clinical overreach | Unreviewed recommendation is presented as treatment | Workflow states, clinical-scope rules, human approval | State-transition tests | TODO | TODO |
| Vendor exposure | Data sent to an unapproved feature or retained unexpectedly | Vendor register, contracts, minimum necessary, egress controls | Configuration and contract review | TODO | TODO |
| Destructive or corrupt migration | Longitudinal records are lost or rewritten | Migration review, backups, restoration, immutable history | Migration and restore tests | TODO | TODO |
| Insider misuse | Authorized user browses records without a business need | Minimum necessary, assignment rules, auditing, access review | Audit review process | TODO | TODO |

## Review triggers

Update this model when:

- architecture or trust boundaries change
- a vendor or AI service is added
- a new role or export is introduced
- health-data categories expand
- authentication or authorization changes
- a material incident or near miss occurs
- a major release is prepared

## Acceptance

A threat is not closed because a control is described. Link executable tests, configuration evidence, monitoring, or an approved risk decision.
