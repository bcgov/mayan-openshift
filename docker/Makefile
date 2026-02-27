#!make
include config.env

ifneq ($(wildcard config-local.env),)
	include config-local.env
endif

CONSOLE_COLUMNS ?= `echo $$(tput cols)`
CONSOLE_LINES ?= `echo $$(tput lines)`
IMAGE_VERSION ?= `cat docker/rootfs/version`
DOCKER_HOST_REGISTRY_NAME ?= $(DOCKER_HOST_REGISTRY_NAME)
DOCKER_HOST_REGISTRY_PORT ?= $(DOCKER_HOST_REGISTRY_PORT)
DOCKER_IMAGE_MAYAN_NAME ?= $(DOCKER_IMAGE_MAYAN_NAME)
DOCKER_IMAGE_DATE_TIME ?= `date -Iseconds  --utc`
DOCKER_IMAGE_LABELS ?= --label org.opencontainers.image.created="$(DOCKER_IMAGE_DATE_TIME)" --label org.opencontainers.image.version=$(IMAGE_VERSION) $(DOCKER_IMAGE_LABELS_EXTRA)
MAYAN_TEST_MEDIA_ROOT ?= /tmp/mayan-test

-include docker/makefiles/build.mk
-include docker/makefiles/compose.mk
-include docker/makefiles/manifest.mk
-include docker/makefiles/registry.mk
-include docker/makefiles/staging.mk
-include docker/makefiles/testing.mk
