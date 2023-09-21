# src/make/clean-install-dockers.func.mk
# only the clean install dockers calls here ...
# TODO: figure a more elegant and generic way to avoid this copy paste ...
#

SHELL = bash
PRODUCT := $(shell basename $$PWD)


.PHONY: clean-install-infra-monitor-ui  ## @-> setup the whole local infra-ui environment no cache
clean-install-infra-monitor-ui:
	$(call build-img,infra-monitor-ui,--no-cache,4200)


.PHONY: install-infra-monitor-ui  ## @-> setup the whole local infra-ui environment
install-infra-monitor-ui:
	$(call build-img,infra-monitor-ui,,4200)


.PHONY: clean-install-status-monitor-ui  ## @-> setup the whole local status-ui environment no cache
clean-install-status-monitor-ui:
	$(call build-img,status-monitor-ui,--no-cache,8080)


.PHONY: install-status-monitor-ui  ## @-> setup the whole local status-ui environment
install-status-monitor-ui:
	$(call build-img,status-monitor-ui,,8080)
