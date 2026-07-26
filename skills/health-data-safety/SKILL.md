---
name: health-data-safety
description: Review and govern any feature that creates, reads, changes, transmits, logs, exports, deletes, or authorizes access to participant identity or health information. Invoke for authentication, authorization, medical history, biomarkers, laboratory data, uploads, AI processing, analytics, notifications, integrations, audit logs, retention, exports, production infrastructure, or vendor changes. Produce a data-flow and access review, identify unresolved PHI/HIPAA boundaries, require minimum-necessary access and verification tests, and stop before implementation when an external service, authorization rule, or compliance assumption is unapproved.
---

# Health Data Safety

Apply this workflow before implementing or approving health-data work. Treat this skill as an engineering guardrail, not as a legal determination that Optional Aging is or is not a HIPAA regulated entity.

## 1. Classify the data

Identify every data class involved:

- ePHI or PHI, if the workflow is within a HIPAA-regulated boundary
- sensitive health information outside a confirmed HIPAA boundary
- personally identifiable information
- de-identified data with the de-identification method recorded
- synthetic data
- public or operational data

When applicability is unresolved, use the more protective control set and record the legal/compliance question as open.

## 2. Trace the complete data flow

Map where data:

1. originates
2. enters the system
3. is validated and transformed
4. is stored
5. is logged or observed
6. is sent to another service or person
7. is exported, retained, corrected, or deleted

Name each trust boundary, role, service, vendor, datastore, queue, log sink, analytics tool, and notification channel. Read `references/architecture-boundaries.md` for the Optional Aging baseline.

## 3. Verify authorization and minimum necessary access

For every operation, state:

- who initiates it
- whose record is affected
- the required role and relationship
- the server-side authorization rule
- the minimum fields required
- the audit event produced
- the expected denial behavior

Never rely on a participant ID, organization ID, role, ownership claim, or authorization result supplied by the client. Require negative tests for cross-participant, unassigned-coach, cross-organization, and privilege-escalation attempts.

## 4. Verify external services and AI processing

Before transmitting health data to any external service, confirm:

- the service and exact product are approved for the data class
- contractual requirements, including a BAA when applicable, are resolved
- retention, training, human-review, regional, logging, and subprocessor behavior are understood
- only the minimum necessary fields are transmitted
- prompts, outputs, traces, and error logs cannot leak health data
- source provenance and human verification are preserved

Do not infer that every product from an approved vendor is approved. Record uncertainty in the vendor register and stop the data transfer path until approved.

## 5. Apply the control baseline

Read `references/health-data-security.md` when the work touches production data, vendors, infrastructure, authentication, authorization, uploads, exports, logging, retention, or incidents.

At minimum require:

- encryption in transit and at rest
- unique identities and strong authentication
- least privilege and separation of duties
- server-side authorization
- immutable or append-only security-relevant audit events
- redaction and data minimization in logs
- secure secret management
- validated uploads and safe temporary-file handling
- backup, recovery, retention, and deletion behavior
- incident detection and escalation ownership
- synthetic test fixtures by default

## 6. Apply the clinical-scope boundary

Read `references/clinical-scope.md` when the feature generates health interpretations, recommendations, escalation messages, medication content, or coach workflows.

AI and coaches may support education, prioritization, adherence, and escalation within approved protocols. They must not independently diagnose, prescribe, change medication, or represent an automated recommendation as clinician approval.

## 7. Produce the review packet

Before implementation, return:

```text
DATA CLASSES
<what data is involved and why>

DATA FLOW
<source -> client -> API -> services -> storage -> outputs>

ACCESS MODEL
<roles, relationships, minimum fields, authorization rules>

EXTERNAL SERVICES
<service, data sent, approval/BAA status, retention, unresolved questions>

RISKS AND CONTROLS
<important threats and required controls>

REQUIRED TESTS
<positive, negative, logging, audit, deletion, and recovery checks>

DECISION
APPROVED TO IMPLEMENT | APPROVED WITH CONDITIONS | BLOCKED

OPEN QUESTIONS
<owner and evidence required to resolve each one>
```

Use `BLOCKED` when a PHI boundary, external-service approval, authorization rule, retention requirement, or clinical-review requirement is unresolved.

## 8. Verify before completion

Before claiming the work is safe or complete:

- run the relevant unit, integration, authorization, and build checks
- inspect logs and telemetry for prohibited data
- verify audit events and denial paths
- verify the actual vendor/service configuration, not only documentation
- state what was not verified

Do not claim HIPAA compliance. Report implemented controls, evidence, limitations, and remaining organizational or legal dependencies.
