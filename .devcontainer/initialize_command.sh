#!/usr/bin/env bash
set -eo pipefail

#######################################
# The script is executed before the eb-devkit container starts.
# It:
# - Checks the pre-conditions of the user environment to use the Dev Container
# - Creates the timezone.env file, which is used to setup the time zone in the eb-devkit container.
#   The container time zone is then equal to the time zone in the host system.
#######################################

SCRIPT_PATH=$(readlink -f "$0")
SCRIPT_DIR=$(dirname -- "${SCRIPT_PATH}")

HOST_GITCONFIG="${HOME}/.gitconfig"

create_timezone_env_file() {
  local TZ
  local TIMEZONE_FILE
  local ENV_FILE
  TIMEZONE_FILE=/etc/timezone
  ENV_FILE="${SCRIPT_DIR}/timezone.env"
  if [[ -f "${TIMEZONE_FILE}" ]]
  then
    TZ="$(head -1 /etc/timezone)"
    echo "Time zone in the container: TZ=${TZ}"
    echo TZ="${TZ}" > "${ENV_FILE}"
  else
    echo "${TIMEZONE_FILE} not found on host, using default time zone in container."
    touch "${ENV_FILE}"
  fi
}

copy_gitconfig() {
  echo "Copying ${HOST_GITCONFIG} to ${SCRIPT_DIR}"
  cp "${HOST_GITCONFIG}" "${SCRIPT_DIR}/"
}

copy_gitconfig
create_timezone_env_file