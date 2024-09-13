#!/bin/sh

# -e  Exit immediately if a command exits with a non-zero status.
set -e

any_to_bool () {
    local argument="$(echo ${1} | tr '[:upper:]' '[:lower:]')"

    if [ "${argument}" = true ] || [ "${argument}" = t ] || [ "${argument}" = yes ] || [ "${argument}" = y ] || [ "${argument}" = 1 ]; then
        local function_result=True
        echo "$function_result"
    fi
}

apt_get_install() {
    apt-get update
    apt-get install --auto-remove --force-yes --no-install-recommends --yes "$@"
    apt-get clean
    rm --force --recursive /var/lib/apt/lists/*
}

initial_setup() {
    echo "mayan: initial_setup()"

    ${MAYAN_BIN} common_initial_setup --force --no-dependencies
}

make_ready() {
    # Check if this is a new install, otherwise try to upgrade the existing
    # installation on subsequent starts.
    if [ ! -f $INSTALL_FLAG ]; then
        initial_setup
    else
        perform_upgrade
    fi
}

os_package_installs() {
    echo "mayan: os_package_installs()"
    if [ "${MAYAN_APT_INSTALLS}" ]; then
        DEBIAN_FRONTEND=noninteractive apt_get_install $MAYAN_APT_INSTALLS
    fi
}

perform_upgrade() {
    echo "mayan: perform_upgrade()"
    ${MAYAN_BIN} common_perform_upgrade --no-dependencies
}

pip_installs() {
    echo "mayan: pip_installs()"
    if [ "${MAYAN_PIP_INSTALLS}" ]; then
        ${MAYAN_PIP_BIN} install $MAYAN_PIP_INSTALLS
    fi
}

update_uid_gid() {
    result="$(any_to_bool ${MAYAN_COMMON_DISABLE_LOCAL_STORAGE})"

    if [ "${result}" ]; then
        echo "mayan: skipping uid and gid update."
    else
        # Change the owner of the /var/lib/mayan always to allow adding the
        # initial files. Top level only.
        chown mayan:mayan ${MAYAN_MEDIA_ROOT}

        echo "mayan: update_uid_gid()"
        groupmod mayan --gid ${MAYAN_USER_GID} --non-unique
        usermod mayan --uid ${MAYAN_USER_UID} --non-unique

        if [ ${MAYAN_USER_UID} -ne ${DEFAULT_USER_UID} ] || [ ${MAYAN_USER_GID} -ne ${DEFAULT_USER_GID} ]; then
            echo "mayan: Updating file ownership. This might take a while if there are many documents."
            chown --recursive mayan:mayan ${MAYAN_INSTALL_DIR} ${MAYAN_STATIC_ROOT}
            if [ "${MAYAN_SKIP_CHOWN_ON_STARTUP}" = "true" ]; then
                echo "mayan: skipping chown on startup"
            else
                chown --recursive mayan:mayan ${MAYAN_MEDIA_ROOT}
            fi
        fi
    fi
}

# Start execution here.
echo "mayan: starting entrypoint.sh"
INSTALL_FLAG=/var/lib/mayan/system/SECRET_KEY
CELERY_CONCURRENCY_ARGUMENT=--concurrency=
CELERY_MAX_MEMORY_PER_CHILD_ARGUMENT=--max-memory-per-child=
CELERY_MAX_TASKS_PER_CHILD_ARGUMENT=--max-tasks-per-child=

DEFAULT_USER_GID=0
DEFAULT_USER_UID=1000

export MAYAN_USER_GID=${MAYAN_USER_GID:-${DEFAULT_USER_GID}}
export MAYAN_USER_UID=${MAYAN_USER_UID:-${DEFAULT_USER_UID}}

export MAYAN_ALLOWED_HOSTS='["*"]'
export MAYAN_BIN=/opt/mayan-edms/bin/mayan-edms.py
export MAYAN_INSTALL_DIR=/opt/mayan-edms
export MAYAN_PYTHON_BIN_DIR=/opt/mayan-edms/bin/
export MAYAN_MEDIA_ROOT=/var/lib/mayan
export MAYAN_SETTINGS_MODULE=${MAYAN_SETTINGS_MODULE:-mayan.settings.production}

# Set DJANGO_SETTINGS_MODULE to MAYAN_SETTINGS_MODULE to avoid two
# different environment variables for the same setting.
export DJANGO_SETTINGS_MODULE=${MAYAN_SETTINGS_MODULE}

export MAYAN_GUNICORN_BIN=${MAYAN_PYTHON_BIN_DIR}gunicorn
export MAYAN_GUNICORN_REQUESTS_JITTER=${MAYAN_GUNICORN_REQUESTS_JITTER}
export MAYAN_GUNICORN_LIMIT_REQUEST_LINE=${MAYAN_GUNICORN_LIMIT_REQUEST_LINE}
export MAYAN_GUNICORN_MAX_REQUESTS=${MAYAN_GUNICORN_MAX_REQUESTS}
export MAYAN_GUNICORN_WORKER_CLASS=${MAYAN_GUNICORN_WORKER_CLASS}
export MAYAN_GUNICORN_WORKERS=${MAYAN_GUNICORN_WORKERS}
export MAYAN_GUNICORN_TIMEOUT=${MAYAN_GUNICORN_TIMEOUT}
export MAYAN_PIP_BIN=${MAYAN_PYTHON_BIN_DIR}pip
export MAYAN_STATIC_ROOT=${MAYAN_INSTALL_DIR}/static

# Setup worker environment variables.

MAYAN_WORKER_A_CONCURRENCY=${MAYAN_WORKER_A_CONCURRENCY:-0}

if [ "$MAYAN_WORKER_A_CONCURRENCY" -eq 0 ]; then
    MAYAN_WORKER_A_CONCURRENCY=
else
    MAYAN_WORKER_A_CONCURRENCY="${CELERY_CONCURRENCY_ARGUMENT}${MAYAN_WORKER_A_CONCURRENCY}"
fi
export MAYAN_WORKER_A_CONCURRENCY

MAYAN_WORKER_A_MAX_MEMORY_PER_CHILD=${MAYAN_WORKER_A_MAX_MEMORY_PER_CHILD:-300000}

if [ "$MAYAN_WORKER_A_MAX_MEMORY_PER_CHILD" -eq 0 ]; then
    MAYAN_WORKER_A_MAX_MEMORY_PER_CHILD=
else
    MAYAN_WORKER_A_MAX_MEMORY_PER_CHILD="${CELERY_MAX_MEMORY_PER_CHILD_ARGUMENT}${MAYAN_WORKER_A_MAX_MEMORY_PER_CHILD}"
fi
export MAYAN_WORKER_A_MAX_MEMORY_PER_CHILD

MAYAN_WORKER_A_MAX_TASKS_PER_CHILD=${MAYAN_WORKER_A_MAX_TASKS_PER_CHILD:-100}

if [ "$MAYAN_WORKER_A_MAX_TASKS_PER_CHILD" -eq 0 ]; then
    MAYAN_WORKER_A_MAX_TASKS_PER_CHILD=
else
    MAYAN_WORKER_A_MAX_TASKS_PER_CHILD="${CELERY_MAX_TASKS_PER_CHILD_ARGUMENT}${MAYAN_WORKER_A_MAX_TASKS_PER_CHILD}"
fi
export MAYAN_WORKER_A_MAX_TASKS_PER_CHILD

MAYAN_WORKER_B_CONCURRENCY=${MAYAN_WORKER_B_CONCURRENCY:-0}

if [ "$MAYAN_WORKER_B_CONCURRENCY" -eq 0 ]; then
    MAYAN_WORKER_B_CONCURRENCY=
else
    MAYAN_WORKER_B_CONCURRENCY="${CELERY_CONCURRENCY_ARGUMENT}${MAYAN_WORKER_B_CONCURRENCY}"
fi
export MAYAN_WORKER_B_CONCURRENCY

MAYAN_WORKER_B_MAX_MEMORY_PER_CHILD=${MAYAN_WORKER_B_MAX_MEMORY_PER_CHILD:-300000}

if [ "$MAYAN_WORKER_B_MAX_MEMORY_PER_CHILD" -eq 0 ]; then
    MAYAN_WORKER_B_MAX_MEMORY_PER_CHILD=
else
    MAYAN_WORKER_B_MAX_MEMORY_PER_CHILD="${CELERY_MAX_MEMORY_PER_CHILD_ARGUMENT}${MAYAN_WORKER_B_MAX_MEMORY_PER_CHILD}"
fi
export MAYAN_WORKER_B_MAX_MEMORY_PER_CHILD

MAYAN_WORKER_B_MAX_TASKS_PER_CHILD=${MAYAN_WORKER_B_MAX_TASKS_PER_CHILD:-100}

if [ "$MAYAN_WORKER_B_MAX_TASKS_PER_CHILD" -eq 0 ]; then
    MAYAN_WORKER_B_MAX_TASKS_PER_CHILD=
else
    MAYAN_WORKER_B_MAX_TASKS_PER_CHILD="${CELERY_MAX_TASKS_PER_CHILD_ARGUMENT}${MAYAN_WORKER_B_MAX_TASKS_PER_CHILD}"
fi
export MAYAN_WORKER_B_MAX_TASKS_PER_CHILD

MAYAN_WORKER_C_CONCURRENCY=${MAYAN_WORKER_C_CONCURRENCY:-0}

if [ "$MAYAN_WORKER_C_CONCURRENCY" -eq 0 ]; then
    MAYAN_WORKER_C_CONCURRENCY=
else
    MAYAN_WORKER_C_CONCURRENCY="${CELERY_CONCURRENCY_ARGUMENT}${MAYAN_WORKER_C_CONCURRENCY}"
fi
export MAYAN_WORKER_C_CONCURRENCY

MAYAN_WORKER_C_MAX_MEMORY_PER_CHILD=${MAYAN_WORKER_C_MAX_MEMORY_PER_CHILD:-300000}

if [ "$MAYAN_WORKER_C_MAX_MEMORY_PER_CHILD" -eq 0 ]; then
    MAYAN_WORKER_C_MAX_MEMORY_PER_CHILD=
else
    MAYAN_WORKER_C_MAX_MEMORY_PER_CHILD="${CELERY_MAX_MEMORY_PER_CHILD_ARGUMENT}${MAYAN_WORKER_C_MAX_MEMORY_PER_CHILD}"
fi
export MAYAN_WORKER_C_MAX_MEMORY_PER_CHILD

MAYAN_WORKER_C_MAX_TASKS_PER_CHILD=${MAYAN_WORKER_C_MAX_TASKS_PER_CHILD:-100}

if [ "$MAYAN_WORKER_C_MAX_TASKS_PER_CHILD" -eq 0 ]; then
    MAYAN_WORKER_C_MAX_TASKS_PER_CHILD=
else
    MAYAN_WORKER_C_MAX_TASKS_PER_CHILD="${CELERY_MAX_TASKS_PER_CHILD_ARGUMENT}${MAYAN_WORKER_C_MAX_TASKS_PER_CHILD}"
fi
export MAYAN_WORKER_C_MAX_TASKS_PER_CHILD

MAYAN_WORKER_D_CONCURRENCY=${MAYAN_WORKER_D_CONCURRENCY:-1}

if [ "$MAYAN_WORKER_D_CONCURRENCY" -eq 0 ]; then
    MAYAN_WORKER_D_CONCURRENCY=
else
    MAYAN_WORKER_D_CONCURRENCY="${CELERY_CONCURRENCY_ARGUMENT}${MAYAN_WORKER_D_CONCURRENCY}"
fi
export MAYAN_WORKER_D_CONCURRENCY

MAYAN_WORKER_D_MAX_MEMORY_PER_CHILD=${MAYAN_WORKER_D_MAX_MEMORY_PER_CHILD:-300000}

if [ "$MAYAN_WORKER_D_MAX_MEMORY_PER_CHILD" -eq 0 ]; then
    MAYAN_WORKER_D_MAX_MEMORY_PER_CHILD=
else
    MAYAN_WORKER_D_MAX_MEMORY_PER_CHILD="${CELERY_MAX_MEMORY_PER_CHILD_ARGUMENT}${MAYAN_WORKER_D_MAX_MEMORY_PER_CHILD}"
fi
export MAYAN_WORKER_D_MAX_MEMORY_PER_CHILD

MAYAN_WORKER_D_MAX_TASKS_PER_CHILD=${MAYAN_WORKER_D_MAX_TASKS_PER_CHILD:-10}

if [ "$MAYAN_WORKER_D_MAX_TASKS_PER_CHILD" -eq 0 ]; then
    MAYAN_WORKER_D_MAX_TASKS_PER_CHILD=
else
    MAYAN_WORKER_D_MAX_TASKS_PER_CHILD="${CELERY_MAX_TASKS_PER_CHILD_ARGUMENT}${MAYAN_WORKER_D_MAX_TASKS_PER_CHILD}"
fi
export MAYAN_WORKER_D_MAX_TASKS_PER_CHILD

MAYAN_WORKER_E_CONCURRENCY=${MAYAN_WORKER_E_CONCURRENCY:-1}

if [ "$MAYAN_WORKER_E_CONCURRENCY" -eq 0 ]; then
    MAYAN_WORKER_E_CONCURRENCY=
else
    MAYAN_WORKER_E_CONCURRENCY="${CELERY_CONCURRENCY_ARGUMENT}${MAYAN_WORKER_E_CONCURRENCY}"
fi
export MAYAN_WORKER_E_CONCURRENCY

MAYAN_WORKER_E_MAX_MEMORY_PER_CHILD=${MAYAN_WORKER_E_MAX_MEMORY_PER_CHILD:-300000}

if [ "$MAYAN_WORKER_E_MAX_MEMORY_PER_CHILD" -eq 0 ]; then
    MAYAN_WORKER_E_MAX_MEMORY_PER_CHILD=
else
    MAYAN_WORKER_E_MAX_MEMORY_PER_CHILD="${CELERY_MAX_MEMORY_PER_CHILD_ARGUMENT}${MAYAN_WORKER_E_MAX_MEMORY_PER_CHILD}"
fi
export MAYAN_WORKER_E_MAX_MEMORY_PER_CHILD

MAYAN_WORKER_E_MAX_TASKS_PER_CHILD=${MAYAN_WORKER_E_MAX_TASKS_PER_CHILD:-10}

if [ "$MAYAN_WORKER_E_MAX_TASKS_PER_CHILD" -eq 0 ]; then
    MAYAN_WORKER_E_MAX_TASKS_PER_CHILD=
else
    MAYAN_WORKER_E_MAX_TASKS_PER_CHILD="${CELERY_MAX_TASKS_PER_CHILD_ARGUMENT}${MAYAN_WORKER_E_MAX_TASKS_PER_CHILD}"
fi
export MAYAN_WORKER_E_MAX_TASKS_PER_CHILD


if mount | grep '/dev/shm' > /dev/null; then
    export MAYAN_GUNICORN_TEMPORARY_DIRECTORY="--worker-tmp-dir /dev/shm"
else
    export MAYAN_GUNICORN_TEMPORARY_DIRECTORY=
fi

# Allow importing of user setting modules.
export PYTHONPATH=$PYTHONPATH:$MAYAN_MEDIA_ROOT

if [ "${MAYAN_DOCKER_SCRIPT_PRE_SETUP}" ]; then
    eval "${MAYAN_DOCKER_SCRIPT_PRE_SETUP}"
fi

${MAYAN_PYTHON_BIN_DIR}python3 /usr/local/bin/wait.py ${MAYAN_DOCKER_WAIT}
os_package_installs || true
pip_installs || true

if [ "${MAYAN_DOCKER_SCRIPT_POST_SETUP}" ]; then
    eval "${MAYAN_DOCKER_SCRIPT_POST_SETUP}"
fi

case "$1" in

run_all)
    make_ready
    /usr/local/bin/run_all.sh
    ;;

run_celery)
    shift
    /usr/local/bin/run_celery.sh "${@}"
    ;;

run_command)
    shift
    ${MAYAN_BIN} ${@}
    ;;

run_frontend)
    exec /usr/local/bin/run_frontend.sh
    ;;

run_initial_setup)
    initial_setup
    ;;

run_perform_upgrade)
    perform_upgrade
    ;;

run_initial_setup_or_perform_upgrade)
    make_ready
    ;;

run_tests)
    make_ready
    shift
    /usr/local/bin/run_tests.sh "${@}"
    ;;

run_worker)
    shift
    exec  /usr/local/bin/run_worker.sh "${@}"
    ;;

*)
    "$@"
    ;;

esac