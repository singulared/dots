#!/usr/bin/env bash
# Dashboard line for hitbox: stars, open issues, open PRs and crates.io downloads,
# with deltas since the previous successful run.
set -euo pipefail

CACHE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/nvim/oss-stats.json"
mkdir -p "$(dirname "$CACHE_FILE")"

fetch() {
  local gh_data
  gh_data=$(gh api graphql -f query='{
    repository(owner: "hit-box", name: "hitbox") {
      stargazerCount
      issues(states: OPEN) { totalCount }
      pullRequests(states: OPEN) { totalCount }
    }
  }' 2>/dev/null) || return 1
  stars=$(jq -er '.data.repository.stargazerCount' <<<"$gh_data") || return 1
  issues=$(jq -er '.data.repository.issues.totalCount' <<<"$gh_data") || return 1
  prs=$(jq -er '.data.repository.pullRequests.totalCount' <<<"$gh_data") || return 1
  downloads=$(curl -fsS --max-time 5 -H "User-Agent: nvim-dashboard" \
    https://crates.io/api/v1/crates/hitbox | jq -er '.crate.downloads') || return 1
  for n in "$stars" "$issues" "$prs" "$downloads"; do
    [[ $n =~ ^[0-9]+$ ]] || return 1
  done
}

if ! fetch; then
  echo "Hitbox stats unavailable (offline or rate-limited)"
  exit 0
fi

# Load previous values from cache
prev_stars="" prev_issues="" prev_prs="" prev_downloads=""
if [[ -s $CACHE_FILE ]]; then
  read -r prev_stars prev_issues prev_prs prev_downloads < <(
    jq -r '"\(.stars) \(.issues) \(.prs) \(.downloads)"' "$CACHE_FILE" 2>/dev/null
  ) || true
fi

# Format delta: green for positive, red for negative
delta() {
  local current=$1 previous=$2
  [[ $previous =~ ^[0-9]+$ ]] || return 0
  local diff=$((current - previous))
  if ((diff > 0)); then
    printf " \033[32m+%s\033[0m" "$diff"
  elif ((diff < 0)); then
    printf " \033[31m%s\033[0m" "$diff"
  fi
}

printf "Hitbox\t\t  %s%s   %s%s   %s%s   %s%s downloads\n" \
  "$stars" "$(delta "$stars" "$prev_stars")" \
  "$issues" "$(delta "$issues" "$prev_issues")" \
  "$prs" "$(delta "$prs" "$prev_prs")" \
  "$downloads" "$(delta "$downloads" "$prev_downloads")"

# Save current values atomically, so a failed write never wipes the baseline
tmp=$(mktemp "$CACHE_FILE.XXXXXX")
jq -n \
  --argjson stars "$stars" \
  --argjson issues "$issues" \
  --argjson prs "$prs" \
  --argjson downloads "$downloads" \
  '{stars: $stars, issues: $issues, prs: $prs, downloads: $downloads}' >"$tmp"
mv "$tmp" "$CACHE_FILE"
