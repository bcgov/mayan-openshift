#!make

docker-manifest-create: ## Merge amd64 and arm64 images into one manifest.
docker-manifest-create: docker-manifest-delete
	docker manifest create \
	$(DOCKER_IMAGE_NAME_FULL) \
	$(DOCKER_IMAGE_NAME_FULL)-amd64 \
	$(DOCKER_IMAGE_NAME_FULL)-arm64

docker-manifest-delete: ## Delete the manifest.
	docker manifest rm \
	$(DOCKER_IMAGE_NAME_FULL) || true

docker-manifest-push: ## Push the manifest.
	docker manifest push \
	$(DOCKER_IMAGE_NAME_FULL)
