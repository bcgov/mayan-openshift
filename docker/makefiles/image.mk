#!make

docker-image-push-amd64: ## Push the amd64 image to the Docker registry.
	docker image push \
	$(DOCKER_IMAGE_NAME_FULL)-amd64

docker-image-push-all: ## Push all images to the Docker registry.
docker-image-push-all: docker-image-push-amd64 docker-image-push-arm64
	# /etc/docker/daemon.json {"insecure-registries" : ["docker-registry.local:5000"]}
	# /etc/hosts <ip address>  docker-registry.local

docker-image-push-arm64: ## Push the arm64 image to the Docker registry.
	docker image push \
	$(DOCKER_IMAGE_NAME_FULL)-arm64

docker-image-push: ## Push images to the Docker registry.
	docker image tag \
	$(DOCKER_IMAGE_MAYAN_NAME):$(IMAGE_VERSION)-amd64 \
	$(DOCKER_IMAGE_NAME_FULL)-amd64
	docker image tag \
	$(DOCKER_IMAGE_MAYAN_NAME):$(IMAGE_VERSION)-arm64 \
	$(DOCKER_IMAGE_NAME_FULL)-arm64
	docker image push \
	$(DOCKER_IMAGE_NAME_FULL)-amd64
	docker image push \
	$(DOCKER_IMAGE_NAME_FULL)-arm64
	# /etc/docker/daemon.json {"insecure-registries" : ["docker-registry.local:5000"]}
	# /etc/hosts <ip address>  docker-registry.local

docker-image-pull: ## Pull an image from the Docker registry.
	docker image pull \
	$(DOCKER_IMAGE_NAME_FULL)
	docker image tag \
	$(DOCKER_IMAGE_NAME_FULL) \
	$(DOCKER_IMAGE_MAYAN_NAME):$(DOCKER_IMAGE_TAG)
