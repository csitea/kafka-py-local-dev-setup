# src/make/clean-install-dockers.func.mk
# Keep all (clean and regular) docker install functions in here.

.PHONY: clean-install-tf-runner  ## @-> setup the whole local tf-runner environment for python no cache
clean-install-tf-runner:
	@sudo rm -r ${PRODUCT_DIR}/bin
	$(call build-img,tf-runner,--no-cache,${TPL_GEN_PORT})
	make start-tf-runner

.PHONY: install-tf-runner  ## @-> setup the whole local tf-runner environment for python
install-tf-runner:
	@sudo rm -r ${PRODUCT_DIR}/bin
	$(call build-img,tf-runner,,${TPL_GEN_PORT})
	make start-tf-runner

.PHONY: build-tf-runner  ## @-> setup the whole local tf-runner environment for python no cache
build-tf-runner:
	$(call build-img,tf-runner,--no-cache,${TPL_GEN_PORT})

.PHONY: start-tf-runner  ## @-> setup the whole local tf-runner environment for python no cache
start-tf-runner:
	$(call start-img,tf-runner,--no-cache,${TPL_GEN_PORT})

.PHONY: stop-tf-runner
stop-tf-runner:
	CONTAINER_NAME=tf-runner
	$(call stop-and-remove-docker-container)
