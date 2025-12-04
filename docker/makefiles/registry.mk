#!make

docker-registry-catalog: ## Show the test Docker registry catalog.
	curl http://$(DOCKER_HOST_REGISTRY_NAME)/v2/_catalog

docker-registry-run: # Launch a test Docker registry.
	docker container run \
	--detach \
	--name registry \
	--publish 5000:5000 \
	registry:2

docker-registry-tags: ## Show the tags for the image in the test Docker registry.
	curl http://$(DOCKER_HOST_REGISTRY_NAME)/v2/$(DOCKER_IMAGE_MAYAN_NAME)/tags/list
