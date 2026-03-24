#!make
docker-dockerfile-openshift-update: ## Update the OpenShift Dockerfile file from the platform template.
docker-dockerfile-openshift-update: copy-config-env
	./manage.py platform_template docker_dockerfile_openshift > docker/Dockerfile.openshift


docker-build-openshift: ## Build a new OpenShift-compatible image locally.
docker-build-openshift: docker-dockerfile-openshift-update docker-buildkitd-config-create
	docker buildx rm mirrored || true
	docker context rm tls-context || true
	docker context create tls-context
	docker buildx create --bootstrap --config /tmp/buildkitd.toml --driver docker-container --name mirrored --use tls-context
	DOCKER_BUILDKIT=1 docker build --build-arg APT_PROXY=$(APT_PROXY) --build-arg PIP_INDEX_URL=$(PIP_INDEX_URL) --build-arg PIP_TRUSTED_HOST=$(PIP_TRUSTED_HOST) --build-arg HTTP_PROXY=$(HTTP_PROXY) --build-arg HTTPS_PROXY=$(HTTPS_PROXY) --builder mirrored --file docker/Dockerfile.openshift $(DOCKER_IMAGE_LABELS) --load --tag $(DOCKER_IMAGE_MAYAN_NAME):$(IMAGE_VERSION)-openshift .
	docker buildx stop mirrored

do_dollar_escape = $(subst $$,\$$,$(1))

PYTHON_BIN ?= python
VERSION_SCRIPT_BIN ?= mayan/apps/dependencies/versions.py

DOCKER_CONSOLE_COLUMNS ?= `echo $$(tput cols)`
DOCKER_CONSOLE_LINES ?= `echo $$(tput lines)`

# Registry private

DOCKER_REGISTRY_NAME ?= $(CONFIG_DOCKER_REGISTRY_NAME)
DOCKER_REGISTRY_PASSWORD ?= $(CONFIG_DOCKER_REGISTRY_PASSWORD)

ifeq ($(origin DOCKER_REGISTRY_USERNAME), undefined)
  DOCKER_REGISTRY_USERNAME := $(CONFIG_DOCKER_REGISTRY_USERNAME)
endif

DOCKER_REGISTRY_USERNAME_ESCAPED := $(call do_dollar_escape,$(value DOCKER_REGISTRY_USERNAME))

# Registry public

DOCKER_REGISTRY_PUBLIC_NAME ?= $(CONFIG_DOCKER_REGISTRY_PUBLIC_NAME)
DOCKER_REGISTRY_PUBLIC_PASSWORD ?= $(CONFIG_DOCKER_REGISTRY_PUBLIC_PASSWORD)

ifeq ($(origin DOCKER_REGISTRY_PUBLIC_USERNAME), undefined)
  DOCKER_REGISTRY_PUBLIC_USERNAME := $(CONFIG_DOCKER_REGISTRY_PUBLIC_USERNAME)
endif

DOCKER_REGISTRY_PUBLIC_USERNAME_ESCAPED := $(call do_dollar_escape,$(value DOCKER_REGISTRY_PUBLIC_USERNAME))

# Image

DOCKER_IMAGE_NAME ?= $(CONFIG_DOCKER_IMAGE_MAYAN_NAME)
DOCKER_IMAGE_DATE_TIME ?= $(shell date -Iseconds  --utc)
DOCKER_IMAGE_VERSION ?= $(shell cat docker/rootfs/version)
DOCKER_IMAGE_VERSION_MAJOR := $(shell $(PYTHON_BIN) $(VERSION_SCRIPT_BIN) $(DOCKER_IMAGE_VERSION) major)
DOCKER_IMAGE_VERSION_MINOR := $(shell $(PYTHON_BIN) $(VERSION_SCRIPT_BIN) $(DOCKER_IMAGE_VERSION) minor)
DOCKER_IMAGE_TAG ?= $(DOCKER_IMAGE_VERSION)
DOCKER_IMAGE_TAG_EXTRA ?= $(CONFIG_DOCKER_IMAGE_TAG_EXTRA)
DOCKER_IMAGE_LABELS ?= --label org.opencontainers.image.created="$(DOCKER_IMAGE_DATE_TIME)" --label org.opencontainers.image.version=$(DOCKER_IMAGE_VERSION) $(DOCKER_IMAGE_LABELS_EXTRA)
DOCKER_IMAGE_NAME_FULL = $(DOCKER_REGISTRY_NAME)/$(DOCKER_IMAGE_NAME)
DOCKER_IMAGE_NAME_FULL_TAGGED = $(DOCKER_IMAGE_NAME_FULL):$(DOCKER_IMAGE_TAG)
DOCKER_IMAGE_PUBLIC_NAME_FULL = $(DOCKER_REGISTRY_PUBLIC_NAME)/$(DOCKER_IMAGE_NAME)

-include docker/makefiles/build.mk
-include docker/makefiles/compose.mk
-include docker/makefiles/image.mk
-include docker/makefiles/manifest.mk
-include docker/makefiles/registry.mk
-include docker/makefiles/staging.mk
-include docker/makefiles/testing.mk
