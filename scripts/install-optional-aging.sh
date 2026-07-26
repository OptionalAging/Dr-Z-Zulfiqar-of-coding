#!/usr/bin/env bash
# Install the curated Optional Aging profile into a target project.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROFILE_DIR="${REPO_ROOT}/profiles/optional-aging"
MANIFEST="${PROFILE_DIR}/manifest.txt"
PROJECT_DIR=""
DRY_RUN=0
FORCE=0
SKILLS_ONLY=0

usage() {
  cat <<'EOF'
usage: scripts/install-optional-aging.sh --project-dir=PATH [options]

Options:
  --project-dir=PATH  Target project root. Required.
  --dry-run           Show changes without writing.
  --force             Replace existing installed skills and profile files.
  --skills-only       Install only .agents/skills, not AGENTS.md or docs/security.
  -h, --help          Show this help.

Existing AGENTS.md is skipped unless --force is explicitly supplied.
EOF
}

for arg in "$@"; do
  case "$arg" in
    --project-dir=*) PROJECT_DIR="${arg#--project-dir=}" ;;
    --dry-run) DRY_RUN=1 ;;
    --force) FORCE=1 ;;
    --skills-only) SKILLS_ONLY=1 ;;
    -h|--help) usage; exit 0 ;;
    *) printf 'unknown option: %s\n' "$arg" >&2; usage >&2; exit 2 ;;
  esac
done

if [ -z "$PROJECT_DIR" ]; then
  printf '%s\n' 'error: --project-dir=PATH is required' >&2
  exit 2
fi

if [ ! -d "$PROJECT_DIR" ]; then
  printf 'error: target project directory does not exist: %s\n' "$PROJECT_DIR" >&2
  exit 2
fi

if [ ! -f "$MANIFEST" ]; then
  printf 'error: profile manifest not found: %s\n' "$MANIFEST" >&2
  exit 2
fi

if [ -f "${REPO_ROOT}/scripts/scan-secrets.sh" ]; then
  bash "${REPO_ROOT}/scripts/scan-secrets.sh" "$REPO_ROOT"
fi

log() { printf '%s\n' "$*"; }
plan() { printf '  [plan] %s\n' "$*"; }
write_msg() { printf '  [write] %s\n' "$*"; }
skip() { printf '  [skip] %s\n' "$*"; }

copy_dir() {
  local src="$1" dest="$2"
  if [ -e "$dest" ]; then
    if [ "$FORCE" -ne 1 ]; then
      skip "$dest already exists"
      return 0
    fi
    if [ "$DRY_RUN" -eq 1 ]; then
      plan "replace directory $dest"
      return 0
    fi
    rm -rf "$dest"
  fi
  if [ "$DRY_RUN" -eq 1 ]; then
    plan "copy $src -> $dest"
  else
    mkdir -p "$(dirname "$dest")"
    cp -R "$src" "$dest"
    write_msg "$dest"
  fi
}

copy_file() {
  local src="$1" dest="$2"
  if [ -e "$dest" ] && [ "$FORCE" -ne 1 ]; then
    skip "$dest already exists"
    return 0
  fi
  if [ "$DRY_RUN" -eq 1 ]; then
    plan "copy $src -> $dest"
  else
    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
    write_msg "$dest"
  fi
}

log "Optional Aging profile install"
log "  source: $REPO_ROOT"
log "  target: $PROJECT_DIR"
log "  mode: $([ "$DRY_RUN" -eq 1 ] && printf dry-run || printf live)"

while IFS= read -r skill || [ -n "$skill" ]; do
  case "$skill" in
    ''|'#'*) continue ;;
  esac
  src="${REPO_ROOT}/skills/${skill}"
  dest="${PROJECT_DIR}/.agents/skills/${skill}"
  if [ ! -d "$src" ]; then
    printf 'error: manifest skill missing: %s\n' "$src" >&2
    exit 1
  fi
  copy_dir "$src" "$dest"
done < "$MANIFEST"

if [ "$SKILLS_ONLY" -eq 0 ]; then
  copy_file "${PROFILE_DIR}/AGENTS.template.md" "${PROJECT_DIR}/AGENTS.md"
  for src in "${PROFILE_DIR}"/docs/security/*.md; do
    copy_file "$src" "${PROJECT_DIR}/docs/security/$(basename "$src")"
  done
fi

if [ "$DRY_RUN" -eq 0 ] && [ -f "${REPO_ROOT}/scripts/scan-secrets.sh" ]; then
  bash "${REPO_ROOT}/scripts/scan-secrets.sh" "${PROJECT_DIR}/.agents/skills"
  if [ "$SKILLS_ONLY" -eq 0 ]; then
    bash "${REPO_ROOT}/scripts/scan-secrets.sh" "${PROJECT_DIR}/docs/security"
    bash "${REPO_ROOT}/scripts/scan-secrets.sh" "${PROJECT_DIR}/AGENTS.md"
  fi
fi

log "Optional Aging profile install complete. Review all files before committing."
