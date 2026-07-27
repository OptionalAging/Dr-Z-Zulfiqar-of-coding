# Optional Aging Agent Profile

This profile adapts the Zulfqar toolkit for the Optional Aging health-optimization platform. It installs a small project-scoped skill set, an Optional Aging `AGENTS.md` template, and security documentation templates.

## What it installs

- `.agents/skills/health-data-safety`
- `.agents/skills/verification-before-completion`
- `.agents/skills/systematic-debugging`
- `.agents/skills/common-ground`
- `.agents/skills/re-entry`
- `.agents/skills/handoff`
- `AGENTS.md` when the target does not already have one
- `docs/security/` templates

## Preview

```bash
bash scripts/install-optional-aging.sh \
  --project-dir=/path/to/optional-aging-platform \
  --dry-run
```

## Install

```bash
bash scripts/install-optional-aging.sh \
  --project-dir=/path/to/optional-aging-platform
```

The installer skips existing files and skills. Use `--force` only after reviewing the affected paths. An existing `AGENTS.md` is never silently replaced.

## Scope

This profile provides engineering guardrails. It does not establish that Optional Aging is a HIPAA covered entity or business associate, replace a formal security risk analysis, or constitute legal or clinical advice.

## Maintenance

- Edit the canonical skill in `skills/health-data-safety/`.
- Keep project-facing policy templates under `profiles/optional-aging/docs/security/`.
- Update `manifest.txt` only when a skill is approved for every Optional Aging project.
- Test the installer with `--dry-run` before live installation.
