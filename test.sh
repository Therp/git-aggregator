#!/bin/sh
# Version: 0.1.0

set -e

WORK_DIR="$(cd "$(/usr/bin/dirname "${0}")" && /bin/pwd)"
cd "${WORK_DIR}"

if [ ! -d "${WORK_DIR}/.venv" ]; then
    /bin/echo "Environment not found. Please run bootstrap.sh first."
    exit 1
fi

# Create a test environment that will use the development aggregator.
if [ ! -d "${WORK_DIR}/.test_venv" ]; then
    /bin/echo "INFO: Creating Test Virtual Environment in ${WORK_DIR}"
    python3 -m venv .test_venv
else
    /bin/echo "INFO: ${WORK_DIR}/.test_venv exist!"
fi
.  ${WORK_DIR}/.test_venv/bin/activate
pip install --upgrade pip
pip install --upgrade tox
pip install -e ${WORK_DIR}/development/git-aggregator
/bin/echo "INFO: Running tests from ${WORK_DIR}/.test_venv environment!"
.  ${WORK_DIR}/.test_venv/bin/activate

cd ${WORK_DIR}/development/git-aggregator
tox
