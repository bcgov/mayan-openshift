#!make

docker-image-pull: ## Pull an image from the test Docker registry.
	docker image pull \
	$(DOCKER_HOST_REGISTRY_NAME):$(DOCKER_HOST_REGISTRY_PORT)/$(DOCKER_IMAGE_MAYAN_NAME):$(IMAGE_VERSION)
	docker image tag \
	$(DOCKER_HOST_REGISTRY_NAME):$(DOCKER_HOST_REGISTRY_PORT)/$(DOCKER_IMAGE_MAYAN_NAME):$(IMAGE_VERSION) \
	$(DOCKER_IMAGE_MAYAN_NAME):$(IMAGE_VERSION)

docker-image-push: ## Push a built image to the test Docker registry.
	docker image tag \
	$(DOCKER_IMAGE_MAYAN_NAME):$(IMAGE_VERSION) \
	$(DOCKER_HOST_REGISTRY_NAME):$(DOCKER_HOST_REGISTRY_PORT)/$(DOCKER_IMAGE_MAYAN_NAME):$(IMAGE_VERSION)
	docker image push \
	$(DOCKER_HOST_REGISTRY_NAME):$(DOCKER_HOST_REGISTRY_PORT)/$(DOCKER_IMAGE_MAYAN_NAME):$(IMAGE_VERSION)
	# /etc/docker/daemon.json {"insecure-registries" : ["docker-registry.local:5000"]}
	# /etc/hosts <ip address>  docker-registry.local
