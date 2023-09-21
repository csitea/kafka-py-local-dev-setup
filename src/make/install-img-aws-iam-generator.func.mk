# src/make/clean-install-dockers.func.mk
# Keep all (clean and regular) docker install functions in here.

.PHONY: clean-install-aws-iam-generator  ## @-> setup the whole local aws-iam-generator environment for python no cache
clean-install-aws-iam-generator:
	$(call build-img,"aws-iam-generator",--no-cache,${TPL_GEN_PORT})
	make start-aws-iam-generator

.PHONY: install-aws-iam-generator  ## @-> setup the whole local aws-iam-generator environment for python
install-aws-iam-generator:
	$(call build-img,"aws-iam-generator",,${TPL_GEN_PORT})
	make start-aws-iam-generator

.PHONY: build-aws-iam-generator  ## @-> setup the whole local aws-iam-generator environment for python no cache
build-aws-iam-generator:
	$(call build-img,"aws-iam-generator",--no-cache,${TPL_GEN_PORT})

.PHONY: start-aws-iam-generator  ## @-> setup the whole local aws-iam-generator environment for python no cache
start-aws-iam-generator:
	$(call start-img,"aws-iam-generator",--no-cache,${TPL_GEN_PORT})

.PHONY: stop-aws-iam-generator
stop-aws-iam-generator:
	CONTAINER_NAME="aws-iam-generator"
	$(call stop-and-remove-docker-container)

.PHONY: run-aws-iam-generator  ## @-> setup the whole local aws-iam-generator environment for python no cache
run-aws-iam-generator:
	docker exec infra-core-aws-iam-generator-con /bin/bash -c "cd ${PRODUCT_DIR}/src/python/aws-iam-generator/aws_iam_generator && poetry run poetry run python3 main.py"
