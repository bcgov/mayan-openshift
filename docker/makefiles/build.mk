#!make

# BuildKit

docker-buildkitd-config-create:
	@echo "debug = true" > /tmp/buildkitd.toml
	@if [ $(DOCKER_MIRROR) ]; then \
		echo "" >> /tmp/buildkitd.toml; \
		echo '[registry."docker.io"]' >> /tmp/buildkitd.toml; \
		echo '  mirrors = ["$(DOCKER_MIRROR)"]' >> /tmp/buildkitd.toml; \
	fi

docker-buildx-create: docker-buildx-rm docker-buildkitd-config-create
	docker context create \
	tls-context
	docker buildx create \
	--bootstrap \
	--config /tmp/buildkitd.toml \
	--driver docker-container \
	--name mirrored \
	--use tls-context

docker-buildx-rm:
	docker buildx rm \
	mirrored || true
	docker context rm \
	tls-context || true

docker-buildx-stop:
	docker buildx stop \
	mirrored

docker-build: ## Build a new image locally.
docker-build: docker-dockerfile-update docker-buildx-create
	DOCKER_BUILDKIT=1 \
	docker build \
	--build-arg APT_PROXY=$(APT_PROXY) \
	--build-arg PIP_INDEX_URL=$(PIP_INDEX_URL) \
	--build-arg PIP_TRUSTED_HOST=$(PIP_TRUSTED_HOST) \
	--build-arg HTTP_PROXY=$(HTTP_PROXY) \
	--build-arg HTTPS_PROXY=$(HTTPS_PROXY) \
	--builder mirrored \
	--cache-from type=registry,ref=$(DOCKER_IMAGE_MAYAN_NAME):$(IMAGE_VERSION) \
	--cache-to type=registry,ref=$(DOCKER_IMAGE_MAYAN_NAME):$(IMAGE_VERSION),mode=max \
	--file docker/Dockerfile $(DOCKER_IMAGE_LABELS) \
	--output type=docker \
	--tag $(DOCKER_IMAGE_MAYAN_NAME):$(IMAGE_VERSION) \
	.
	$(MAKE) docker-buildx-stop

# Dockerfile

docker-dockerfile-update: ## Update the Dockerfile file from the platform template.
docker-dockerfile-update: config-env-copy
	./manage.py platforms_template docker_dockerfile > docker/Dockerfile
