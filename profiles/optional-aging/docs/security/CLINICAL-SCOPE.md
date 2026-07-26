# Optional Aging Clinical Scope Boundary

Status: product and engineering baseline
Last reviewed: 2026-07-26
Owner: TODO

## Program model

Optional Aging is designed primarily as an education, health-optimization, coaching, and navigation platform. Health coaches do not prescribe medications or independently diagnose disease. Direct licensed-clinician care, when offered, uses a separate reviewed workflow.

## Permitted coach and AI support

- organize participant-provided information
- identify missing or stale information
- apply versioned deterministic assessment and prioritization rules
- provide approved education and lifestyle guidance
- support adherence and behavior change
- draft plans for required human review
- recommend discussion with a licensed clinician
- route participants to approved external clinical resources
- identify protocol-defined safety and escalation conditions

## Prohibited representation

The application must not imply that:

- a coach prescribed or approved a medication
- AI made a medical diagnosis
- an external referral guarantees eligibility or treatment
- an unverified extraction is a confirmed medical fact
- a generated plan has clinician approval when it has not been reviewed
- urgent symptoms are safe to monitor without appropriate escalation

## Medication pathway

Use language such as:

- "Discuss this option with a licensed clinician."
- "A clinician will determine whether this is appropriate for you."
- "You may bring this summary to your primary care clinician or an approved telehealth service."

Store recommendation, coach approval, clinician decision when present, participant action, adverse event, and outcome as distinct records.

## Review states

1. AI proposal
2. coach draft
3. supervisor or clinician review when required
4. published plan
5. superseded, paused, or withdrawn

Record actor, timestamp, protocol version, and reason for each transition.

## Safety design requirements

- protocol-specific exclusions and contraindication checks
- medication and allergy confirmation when relevant
- missing-data and uncertainty handling
- adverse-event reporting
- urgent and emergency instructions
- pause and stop controls
- clear escalation owner and service level
- documentation that educational content is not individualized prescribing

## Jurisdictional review

Professional scope, telehealth, corporate-practice, licensure, and consumer-health requirements vary. Record unresolved jurisdictional questions as blocking assumptions and route them to qualified counsel or clinical leadership.
