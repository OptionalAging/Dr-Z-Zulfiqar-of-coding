# Optional Aging Health Data Security Baseline

Status: engineering baseline
Last reviewed: 2026-07-26
Owner: TODO

## Purpose and limitation

This document defines the minimum engineering controls for Optional Aging systems that handle identity or health information. It does not by itself establish HIPAA compliance or determine whether a specific Optional Aging workflow is a covered-entity, business-associate, or consumer-wellness activity. Those determinations require documented legal and compliance review.

## Current regulatory baseline

The current HIPAA Security Rule remains in effect. It requires administrative, physical, and technical safeguards to protect the confidentiality, integrity, and availability of ePHI. HHS continues to describe the 2024/2025 cybersecurity update as a proposed rule. Optional Aging may adopt appropriate proposed-rule practices as internal security targets without representing them as current legal requirements.

Authoritative references:

- https://www.hhs.gov/hipaa/for-professionals/security/index.html
- https://www.hhs.gov/hipaa/for-professionals/security/guidance/guidance-risk-analysis/index.html
- https://www.hhs.gov/hipaa/for-professionals/security/hipaa-security-rule-nprm/index.html
- https://www.hhs.gov/hipaa/for-professionals/special-topics/health-information-technology/cloud-computing/index.html
- https://www.hhs.gov/hipaa/for-professionals/privacy/guidance/minimum-necessary-requirement/index.html
- https://csrc.nist.gov/pubs/sp/800/66/r2/final

## Non-negotiable controls

### Data and environments

- Classify data before implementation.
- Use synthetic data for development, tests, demos, screenshots, and documentation.
- Keep production, staging, and development separate.
- Prohibit production data in lower environments absent a documented exception.
- Document retention, deletion, backup, restoration, and legal-hold behavior.

### Identity and authorization

- Use unique human and service identities.
- Require MFA for privileged roles.
- Authorize every health-data operation server-side.
- Model participant ownership, coach assignment, organization, and privileged access explicitly.
- Apply least privilege and minimum necessary access.
- Audit privileged, export, correction, and access events.

### Application and API

- The client never connects directly to PostgreSQL.
- Validate token issuer, audience, signature, expiry, and revocation behavior.
- Derive actor, organization, role, and relationship server-side.
- Validate request and response schemas.
- Return only required fields.
- Test denial paths and object-level authorization.

### Encryption and secrets

- Encrypt sensitive data in transit and at rest.
- Store secrets in approved managed secret services.
- Never commit credentials or `.env` files.
- Rotate and revoke credentials through documented processes.
- Do not embed privileged credentials in mobile or web clients.

### Logging and notifications

Do not include health data or direct identifiers in URLs, query strings, analytics, console logs, traces, crash reports, issue trackers, PR text, screenshots, notifications, or test snapshots.

Use correlation IDs and structured events. Keep security audit events sufficiently detailed for investigation while minimizing clinical content.

### Files and AI

- Validate uploaded file type, size, structure, and content.
- Store files outside public paths and use short-lived processing locations.
- Treat uploaded text as untrusted and potentially prompt-injecting.
- Preserve source artifact, extraction provenance, correction history, and verification status.
- Use only approved AI services and minimum-necessary input.
- Validate structured output and require human review where the workflow can affect a participant plan or escalation.

### Vendors

- Maintain `VENDOR-PHI-REGISTER.md`.
- Approve the exact service and feature, not only the vendor.
- Resolve BAA and contractual requirements when applicable.
- Record region, retention, training, subprocessors, logging, and incident obligations.
- Block PHI transfer while approval is unresolved.

## Required tests for health-data features

- Correctly authorized user succeeds.
- Unauthenticated user fails.
- Participant A cannot access participant B.
- Unassigned coach cannot access the participant.
- Cross-organization access fails.
- Revoked or downgraded access stops working.
- Health data does not appear in logs, URLs, analytics, traces, or notifications.
- Audit events are produced and contain the expected metadata.
- Export, retention, correction, and deletion rules behave as documented.
- Failure modes preserve integrity and do not broaden access.

## Release gate

A health-data feature cannot be represented as ready when any of these remain unresolved:

- data classification
- server-side authorization rule
- external-service approval
- retention or deletion behavior
- audit requirements
- required human or clinician review
- incident owner
- verification evidence

## Required supporting records

- `PHI-DATA-FLOW.md`
- `THREAT-MODEL.md`
- `VENDOR-PHI-REGISTER.md`
- architecture and security decision records
- formal risk analysis outside the source repository
