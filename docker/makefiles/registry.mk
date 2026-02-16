#!make

docker-registry-catalog: ## Show the test Docker registry catalog.
	curl http://$(DOCKER_REGISTRY_NAME)/v2/_catalog

docker-registry-run: # Launch a test Docker registry.
	docker container run \
	--detach \
	--name registry \
	--publish 5000:5000 \
	registry:2

docker-registry-tags: ## Show the tags for the image in the test Docker registry.
	curl http://$(DOCKER_REGISTRY_NAME)/v2/$(DOCKER_IMAGE_NAME)/tags/list

docker-registry-login: ## Login to the development registry.
	docker login \
	--password '$(DOCKER_REGISTRY_PASSWORD)' \
	--username '$(DOCKER_REGISTRY_USERNAME)' \
	$(DOCKER_REGISTRY_NAME)
