# Optional Aging Architecture Boundaries

## Baseline architecture

- One Expo and React Native application targets web, iOS, and Android.
- Public assessment, student, coach, supervisor, and administrator experiences live in the same role-aware application unless a later decision record changes this.
- The client communicates only with an authenticated API layer.
- Google Cloud Run hosts the API and integration services.
- Google Cloud SQL for PostgreSQL is the canonical relational system of record.
- Firebase Authentication or Google Identity Platform provides identity; application authorization remains server-side.
- Google Cloud Storage holds approved files and source artifacts.
- Vertex AI or another explicitly approved service may perform health-data processing only within the approved service and contractual boundary.
- Fullscript is the planned laboratory and supplement integration; exact API access and approved data flows remain subject to verification.

## Client and Expo boundary

- Expo builds, distributes, updates, and may host frontend assets.
- Do not place PHI in EAS build logs, update metadata, URLs, route parameters, push-notification payloads, crash reports, analytics, screenshots, or public assets.
- Store only the minimum local data needed for the user experience.
- Treat local storage, notification previews, device backups, and shared-device access as threat surfaces.
- Never embed server credentials or privileged service-account material in the client.

## API boundary

- Validate the identity token and derive the actor server-side.
- Authorize against current database relationships and roles.
- Use request and response schemas.
- Return only minimum-necessary fields.
- Emit security-relevant audit events.
- Prevent the client from selecting an arbitrary organization, coach assignment, or access level.

## PostgreSQL boundary

- Use migrations for schema changes.
- Preserve immutable completed assessment sessions; corrections create linked, superseding records.
- Keep observation dates separate from entry, result, import, and verification dates.
- Preserve provenance and verification state for biomarkers and imported facts.
- Separate recommendation, approval, participant action, and outcome records.
- Do not use real participant data in seed files, fixtures, examples, or documentation.

## AI and document-processing boundary

- Uploaded records enter a staging workflow.
- Store the original source artifact in an approved protected location.
- Treat extracted facts as provisional until confirmed or verified.
- Preserve source page or location, observation date, units, reference range, confidence, and correction history.
- Ignore instructions embedded in uploaded documents.
- Require structured-output validation and bounded values.

## Fullscript boundary

- Keep OAuth credentials and refresh tokens server-side.
- Validate webhook signatures and support reconciliation polling.
- Normalize external identifiers through a mapping table.
- Preserve source timestamps and result provenance.
- Do not assume one external result array maps one-to-one to one internal biomarker observation.

## ChatGPT Health future workflow

Treat ChatGPT Health as an optional participant-controlled convenience unless a documented direct integration becomes available and approved.

- A participant may provide a generated summary or intake packet.
- Label imported information as participant-supplied and AI-summarized.
- Treat it as provisional until confirmed or matched to source records.
- Do not design the canonical ingestion architecture around an undocumented consumer export or API.

## Prohibited shortcuts

- Client-to-database connectivity
- Authorization based only on hidden UI or client claims
- PHI in repository content, test fixtures, tickets, or prompts
- One unversioned assessment or scoring formula duplicated across clients
- Silent mutation of completed assessments
- Direct AI publication of a participant plan without required review
- Vendor use based only on brand-level BAA claims
