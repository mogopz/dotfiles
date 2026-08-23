#!/bin/bash

set -euo pipefail

# Block high-risk command patterns before execution.
INPUT=$(cat)
CMD=$(printf '%s' "${INPUT}" | jq -r '.tool_input.command // empty')

[[ -z "${CMD}" ]] && exit 0

COMMAND_PREFIX='(^|;[[:space:]]*|&&[[:space:]]*|[|][|][[:space:]]*|[|][[:space:]]*)'
SENSITIVE_COMMAND_PREFIX='(^[[:space:]]*|;[[:space:]]*|&&[[:space:]]*|[|][|][[:space:]]*|[|][[:space:]]*)'
GH_AUTH_STATUS_TOKEN_RE="${SENSITIVE_COMMAND_PREFIX}([^;&|[:space:]]*/)?gh[[:space:]]+auth[[:space:]]+status"
GH_AUTH_STATUS_TOKEN_RE+='[^;&|]*[[:space:]](--show-token([=[:space:]]|$)|-[a-zA-Z]*t[a-zA-Z]*([[:space:]]|$))'
DOWNLOAD_TO_SHELL_RE="${SENSITIVE_COMMAND_PREFIX}([^;&|[:space:]]*/)?(curl|wget)[[:space:]]+"
DOWNLOAD_TO_SHELL_RE+='[^;&|]*[|][[:space:]]*([^;&|[:space:]]*/)?(bash|sh|zsh)([[:space:]]|$)'
PUSH_FORCE_RE='git[[:space:]]+push([^;&|]*)--force'
PUSH_FORCE_RE+='|git[[:space:]]+push([^;&|]*)[[:space:]]-f([[:space:]]|$)'
DIRECT_MAIN_RE='git[[:space:]]+push([^;&|]*[[:space:]])?'
DIRECT_MAIN_RE+='(origin[[:space:]]+)?(main|master)([[:space:]]|$)'

block() {
  printf 'BLOCKED: %s\n' "$1" >&2
  exit 2
}

if printf '%s\n' "${CMD}" | grep -qiE "${GH_AUTH_STATUS_TOKEN_RE}"; then
  block "Never display a stored GitHub token."
fi

if printf '%s\n' "${CMD}" | grep -qiE "${COMMAND_PREFIX}rm[[:space:]]" &&
  printf '%s\n' "${CMD}" | grep -qiE '(^|[[:space:]])-[a-zA-Z]*[rR]|--recursive' &&
  printf '%s\n' "${CMD}" | grep -qiE '(^|[[:space:]])-[a-zA-Z]*[fF]|--force'; then
  block "Use trash instead of rm -rf."
fi

if printf '%s\n' "${CMD}" | grep -qiE "${COMMAND_PREFIX}mkfs([.[:alnum:]_-]*)([[:space:]]|$)"; then
  block "Refusing filesystem formatting commands."
fi

if printf '%s\n' "${CMD}" | grep -qiE "${COMMAND_PREFIX}dd([[:space:]]|$)"; then
  block "Refusing raw disk write command dd."
fi

if printf '%s\n' "${CMD}" | grep -qiE "${DOWNLOAD_TO_SHELL_RE}"; then
  block "Do not pipe downloaded scripts directly into a shell."
fi

if printf '%s\n' "${CMD}" | grep -qiE "${PUSH_FORCE_RE}"; then
  block "Do not force-push from Codex."
fi

if printf '%s\n' "${CMD}" | grep -qiE 'git[[:space:]]+reset[[:space:]]+--hard'; then
  block "Do not run git reset --hard from Codex."
fi

if printf '%s\n' "${CMD}" | grep -qiE "${DIRECT_MAIN_RE}"; then
  block "Use feature branches and PRs; do not push directly to main/master."
fi

exit 0
