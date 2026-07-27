# Health-Data Flow Inventory

Last reviewed: TODO
Owner: TODO
System or workflow: TODO

Create one section per material workflow. Include sensitive health information even when HIPAA applicability is unresolved.

## Flow template

### Workflow: <name>

Purpose: <why the flow exists>

Data classes: <PHI/ePHI, sensitive health, PII, de-identified, synthetic, operational>

```text
<source> -> <client> -> <API> -> <processing service> -> <storage> -> <authorized output>
```

| Step | Actor/service | Data entering | Processing | Data leaving | Storage/logging | Authorization | Vendor approval | Retention/deletion | Audit event |
|---|---|---|---|---|---|---|---|---|---|
| 1 | TODO | TODO | TODO | TODO | TODO | TODO | TODO | TODO | TODO |

Trust boundaries:

- TODO

Failure and recovery behavior:

- TODO

Open questions:

- TODO

## Initial workflows to document

- Public assessment to verified student account
- Medical-history intake
- Laboratory document upload and extraction
- Fullscript laboratory result ingestion
- Coach review and plan publication
- Participant check-ins and adverse-event escalation
- Data export and account deletion
- Optional future ChatGPT Health-assisted intake
