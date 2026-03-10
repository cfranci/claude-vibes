#!/bin/bash
input=$(cat)

# Get project dir: prefer tracked cwd from hook, fall back to JSON
tracked_dir=$(cat "/tmp/claude-cwd-$PPID" 2>/dev/null)
if [ -n "$tracked_dir" ]; then
  name=$(basename "$tracked_dir")
  branch=$(git -C "$tracked_dir" symbolic-ref --short HEAD 2>/dev/null)
else
  project_dir=$(echo "$input" | jq -r '.workspace.project_dir // .workspace.current_dir // empty')
  name=$(basename "${project_dir:-unknown}")
  branch=$(git symbolic-ref --short HEAD 2>/dev/null)
fi

label="$name"
[ -n "$branch" ] && label="${name} (${branch})"

# Tokens in K
total_in=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
total_out=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
in_k=$(awk "BEGIN {printf \"%.0f\", $total_in/1000}")
out_k=$(awk "BEGIN {printf \"%.0f\", $total_out/1000}")

# Context percentage
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
ctx=""
[ -n "$used" ] && ctx="| ◉ ${used}%"

echo "▸ ${label} | ◇ ${in_k}K↓ ${out_k}K↑ ${ctx}"
