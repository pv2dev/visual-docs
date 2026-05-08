#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
skill_src="$repo_dir/skills/visual-docs"
dry_run=0
targets=()

usage() {
  cat <<'USAGE'
Usage: ./install.sh [--dry-run] [codex|claude|agents|all]

Installs the visual-docs skill into local agent skill directories.

Targets:
  codex   ${CODEX_HOME:-$HOME/.codex}/skills/visual-docs
  claude  $HOME/.claude/skills/visual-docs
  agents  ${AGENTS_HOME:-$HOME/.agents}/skills/visual-docs
  all     all targets

Options:
  --dry-run  print planned writes only
  -h, --help show help
USAGE
}

target_path() {
  case "$1" in
    codex) printf '%s\n' "${CODEX_HOME:-$HOME/.codex}/skills/visual-docs" ;;
    claude) printf '%s\n' "$HOME/.claude/skills/visual-docs" ;;
    agents) printf '%s\n' "${AGENTS_HOME:-$HOME/.agents}/skills/visual-docs" ;;
    *) return 1 ;;
  esac
}

install_one() {
  local target="$1"
  local dest
  dest="$(target_path "$target")"

  if [[ "$dry_run" -eq 1 ]]; then
    printf 'would install %s -> %s\n' "$skill_src" "$dest"
    return
  fi

  local tmp="${dest}.tmp.$$"
  rm -rf "$tmp"
  mkdir -p "$(dirname "$dest")"
  cp -R "$skill_src" "$tmp"
  rm -rf "$dest"
  mv "$tmp" "$dest"
  printf 'installed %s\n' "$dest"
}

if [[ ! -f "$skill_src/SKILL.md" ]]; then
  printf 'missing skill source: %s\n' "$skill_src" >&2
  exit 1
fi

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run)
      dry_run=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    codex|claude|agents)
      targets+=("$1")
      ;;
    all)
      targets=(codex claude agents)
      ;;
    *)
      printf 'unknown argument: %s\n' "$1" >&2
      usage >&2
      exit 2
      ;;
  esac
  shift
done

if [[ "${#targets[@]}" -eq 0 ]]; then
  targets=(codex claude agents)
fi

for target in "${targets[@]}"; do
  install_one "$target"
done
