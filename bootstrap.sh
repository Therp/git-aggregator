#!/bin/sh
# Version: 0.1.0

set -e

WORK_DIR="$(cd "$(/usr/bin/dirname "${0}")" && /bin/pwd)"
cd "${WORK_DIR}"

if [ ! -d "${WORK_DIR}/.venv" ]; then
    /bin/echo "INFO: Creating Virtual Environment in ${WORK_DIR}"
    python3 -m venv .venv
    .  ${WORK_DIR}/.venv/bin/activate
    pip install --upgrade pip
    pip install wheel pipx black pylint ipython pre-commit
    pre-commit install
else
    /bin/echo "INFO: ${WORK_DIR}/.venv exist!"
    .  ${WORK_DIR}/.venv/bin/activate
    pip install --upgrade pip
fi

pip install --upgrade git-aggregator

# Now create our development instance of git-aggregator.
gitaggregate --config=bootstrap_repos.yaml

