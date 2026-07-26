# Health Data Security Reference

## Purpose

Use this reference for engineering decisions involving health information, identity, production infrastructure, vendors, logging, exports, retention, or incidents. It is an internal control baseline and does not replace a formal risk analysis, legal review, workforce policies, vendor contracting, or incident-response program.

## Regulatory status as of 2026-07-26

- The current HIPAA Security Rule remains in effect and requires appropriate administrative, physical, and technical safeguards for the confidentiality, integrity, and availability of ePHI.
- HHS issued a proposed Security Rule update in late 2024 and published it in January 2025. HHS continues to identify it as a proposed rule; proposed requirements are not represented here as current law.
- Optional Aging may adopt proposed-rule practices as internal security targets when they are reasonable, including stronger encryption, multifactor authentication, asset inventories, network segmentation, testing, and written incident procedures.
- NIST SP 800-66 Rev. 2 is the current federal cybersecurity resource guide for implementing the HIPAA Security Rule.

Official references:

- https://www.hhs.gov/hipaa/for-professionals/security/index.html
- https://www.hhs.gov/hipaa/for-professionals/security/guidance/guidance-risk-analysis/index.html
- https://www.hhs.gov/hipaa/for-professionals/security/hipaa-security-rule-nprm/index.html
- https://www.hhs.gov/hipaa/for-professionals/special-topics/health-information-technology/cloud-computing/index.html
- https://www.hhs.gov/hipaa/for-professionals/privacy/guidance/minimum-necessary-requirement/index.html
- https://csrc.nist.gov/pubs/sp/800/66/r2/final

## Data classification

Use the most protective applicable class.

| Class | Examples | Default handling |
|---|---|---|
| ePHI/PHI | Identifiable medical history, laboratory results, medications, diagnoses within a HIPAA-regulated workflow | Approved systems and services only; minimum necessary; audited access |
| Sensitive health information | Identifiable health data when HIPAA applicability is unresolved or outside HIPAA | Apply the ePHI engineering baseline unless a reviewed policy says otherwise |
| PII | Name, email, phone, address, account identifiers | Minimize, encrypt, restrict, and avoid logs |
| De-identified | Data meeting a documented de-identification method | Preserve method, date, and re-identification risk controls |
| Synthetic | Artificial fixtures with no real-person derivation | Preferred for development, tests, demos, screenshots, and documentation |
| Public/operational | Public content and non-sensitive system metadata | Standard security controls |

Never label data de-identified merely because obvious names were removed. Record the method and reviewer.

## Required engineering controls

### Identity and access

- Use unique user and service identities.
- Require strong authentication and MFA for privileged roles.
- Authorize every sensitive operation on the server.
- Model participant, coach assignment, organization, and privileged-role relationships explicitly.
- Apply least privilege and separation of duties.
- Time-bound elevated access and log its reason.
- Define emergency or break-glass access before implementing it.

### Application and API

- Never connect the client directly to PostgreSQL.
- Validate authentication tokens, audience, issuer, expiry, and revocation behavior.
- Derive authorization context server-side.
- Use opaque identifiers where practical; never treat opacity as authorization.
- Prevent insecure direct object reference and mass-assignment vulnerabilities.
- Validate inputs and outputs against explicit schemas.
- Rate-limit sensitive endpoints and protect account recovery.

### Storage and cryptography

- Encrypt data in transit and at rest.
- Use managed key and secret services; never commit credentials or `.env` files.
- Separate production, staging, and development environments.
- Prohibit production data in lower environments unless an approved exception and controls exist.
- Define backup encryption, restoration tests, retention, deletion, and legal-hold behavior.

### Logging, analytics, and observability

Do not place health data or direct identifiers in:

- URLs or query strings
- console logs
- analytics events
- crash reports
- tracing spans
- notification payloads
- issue bodies or pull-request descriptions
- screenshots or test snapshots

Use correlation IDs and stable internal event names. Maintain security and access audit events separately from verbose application logs. Audit events should identify actor, subject, action, resource, timestamp, result, authorization context, and reason when required, without copying clinical content unnecessarily.

### File and document ingestion

- Validate file type, size, structure, and declared content type.
- Defend against path traversal, archive expansion, malformed documents, and malware.
- Store uploads outside publicly served paths.
- Use short-lived processing locations and verified deletion.
- Treat document text as untrusted input, including prompt-injection content.
- Preserve original source, extraction provenance, confidence, correction history, and human verification.

### AI systems

- Send only approved and minimum-necessary fields.
- Confirm the exact model, endpoint, logging, retention, training, and regional behavior.
- Separate source facts, model extraction, model interpretation, coach review, and published plan.
- Validate structured output with schemas and range checks.
- Never permit document instructions to override system policy or tool authorization.
- Require human review for clinical interpretations, intervention plans, adverse-event handling, and escalation pathways.
- Do not place PHI in model debugging dashboards unless expressly approved.

### Vendors and cloud services

- Evaluate the exact service, not only the vendor name.
- Record data categories, purpose, region, retention, subprocessors, security evidence, owner, and approval status.
- Resolve BAA requirements when the service creates, receives, maintains, or transmits ePHI on behalf of a regulated entity.
- Do not assume encrypted no-view storage removes business-associate obligations.
- Reassess vendors when service terms, architecture, or data use changes.

### Incident response

Define:

- event detection and severity levels
- containment authority
- evidence preservation
- credential and token revocation
- vendor notification paths
- legal/privacy escalation
- participant and regulator notification ownership
- post-incident corrective actions

Do not investigate suspected PHI exposure by copying sensitive content into tickets or chat.

## Minimum verification set

Require tests appropriate to the change:

- authorized user succeeds
- unauthorized and unauthenticated users fail
- participant A cannot access participant B
- unassigned coach cannot access the participant
- cross-organization access fails
- downgraded or revoked role loses access
- sensitive fields are absent from logs, URLs, analytics, and notifications
- audit events are created for access, changes, exports, and privileged actions
- retention and deletion rules behave as documented
- backup restoration is periodically demonstrated
- vendor failure and timeout behavior do not expose or corrupt data

## Completion language

Use: "Implemented the listed controls and verified the following checks."

Avoid: "HIPAA compliant," "fully secure," or "safe" unless an authorized compliance process has made that determination.
