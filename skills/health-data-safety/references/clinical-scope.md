# Clinical Scope Reference

## Purpose

Use this reference for participant-facing interpretations, recommendations, coaching workflows, medication content, safety signals, and escalation. It is a conservative product and engineering boundary. It does not determine professional scope-of-practice law in any jurisdiction.

## Optional Aging operating model

- Health coaches support education, behavior change, adherence, prioritization, and navigation within approved protocols.
- Coaches do not prescribe medications or independently diagnose disease.
- Optional Aging may recommend that a participant discuss a medication, laboratory test, device, or evaluation with a licensed clinician.
- Medication access may be supported through approved external telehealth services or the participant's clinician; the platform must not imply that a referral guarantees treatment.
- Direct physician care, when offered, is an exception with its own licensed-clinician workflow and documentation.

## AI boundaries

AI may:

- extract and organize participant-supplied information
- calculate deterministic scores using versioned rules
- summarize trends and identify missing information
- draft educational explanations
- propose a plan for coach or clinician review
- identify protocol-defined safety or escalation conditions

AI must not independently:

- diagnose a participant
- prescribe, initiate, discontinue, or change a medication
- determine that urgent symptoms are harmless
- represent an unreviewed output as clinician-approved
- conceal uncertainty or missing source data
- override a safety rule or human escalation requirement

## Medication language

Preferred language:

- "Discuss this option with a licensed clinician."
- "This may warrant clinician review based on the information available."
- "Eligibility and prescribing decisions belong to the treating clinician."

Avoid:

- "Start this medication."
- "You need this prescription."
- "This is safe for you."
- "Your coach has approved treatment."

## Safety and escalation

Design every recommendation workflow with:

- contraindication and exclusion checks appropriate to the protocol
- participant confirmation of current medications, allergies, pregnancy status when relevant, and major conditions
- uncertainty and missing-data handling
- adverse-event reporting
- urgent and emergency instructions
- clinician escalation ownership
- a documented pause or stop pathway

Do not create a single generic emergency rule for every module. Each protocol must identify its own red flags and escalation pathway, while the application retains a universal emergency disclaimer and contact pathway.

## Published-plan states

Keep these states distinct:

1. AI proposal
2. coach draft
3. clinician or supervisor review when required
4. published plan
5. superseded or withdrawn plan

Store who performed each transition, when it occurred, the governing protocol version, and the reason for a safety-related change.

## Data presentation

Separate:

- participant-reported facts
- source-document observations
- AI-extracted values
- deterministic scores
- AI interpretation
- coach interpretation
- clinician decision
- participant action
- observed outcome

Do not collapse these into one narrative field.
