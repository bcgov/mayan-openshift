#!/bin/sh

# Use -A and not --app. Both are the same but behave differently
# -A can be located before the command while --app cannot.

echo "${MAYAN_PYTHON_BIN_DIR}celery -A mayan $@"
${MAYAN_PYTHON_BIN_DIR}celery -A mayan $@
