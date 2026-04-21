#!/usr/bin/env bash
set -euo pipefail

SKILLS_SRC="${HOME}/.agents/skills"
SKILLS_DST="${HOME}/.claude/skills"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
DIM='\033[2m'
RESET='\033[0m'

echo ""
echo "Syncing skills: ${SKILLS_SRC} → ${SKILLS_DST}"
echo ""

mkdir -p "$SKILLS_DST"

added=0
skipped=0

for skill_path in "$SKILLS_SRC"/*/; do
  skill=$(basename "$skill_path")
  target="${SKILLS_DST}/${skill}"

  if [[ -L "$target" && "$(readlink "$target")" == "${skill_path%/}" ]]; then
    echo -e "  ${DIM}·  ${skill} (already linked)${RESET}"
    ((skipped++)) || true
  elif [[ -e "$target" ]]; then
    echo -e "  ${YELLOW}⚠  ${skill} (exists but isn't a symlink — skipping)${RESET}"
    ((skipped++)) || true
  else
    ln -s "$skill_path" "$target"
    echo -e "  ${GREEN}+  ${skill}${RESET}"
    ((added++)) || true
  fi
done

echo ""
if [[ $added -gt 0 ]]; then
  echo -e "${GREEN}Done.${RESET} $added linked, $skipped skipped."
  echo "Restart Claude Code for new skills to appear."
else
  echo -e "${GREEN}Done.${RESET} All skills already up to date."
fi
echo ""
