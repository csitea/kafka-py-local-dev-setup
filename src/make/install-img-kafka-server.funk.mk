# src/make/clean-install-dockers.func.mk
# Keep all (clean and regular) docker install functions in here.

.PHONY: clean-install-kafka-server  ## @-> setup the whole local kafka-server environment for python no cache
clean-install-kafka-server:
	$(call build-img,kafka-server,--no-cache,9092)
	make start-kafka-server

.PHONY: install-kafka-server  ## @-> setup the whole local kafka-server environment for python
install-kafka-server:
	$(call build-img,kafka-server,,9092)
	make start-kafka-server

.PHONY: build-kafka-server  ## @-> setup the whole local kafka-server environment for python no cache
build-kafka-server:
	$(call build-img,kafka-server,--no-cache,9092)

.PHONY: start-kafka-server  ## @-> setup the whole local kafka-server environment for python no cache
start-kafka-server:
	$(call start-img,kafka-server,--no-cache,9092)

.PHONY: stop-kafka-server
stop-kafka-server:
	CONTAINER_NAME=kafka-server
	$(call stop-and-remove-docker-container)