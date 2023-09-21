# src/make/clean-install-dockers.func.mk
# only the clean install dockers calls here ...
# TODO: figure a more elegant and generic way to avoid this copy paste ...
#

SHELL = bash
PRODUCT := $(shell basename $$PWD)
ORG := $(shell export ORG=$${ORG:-csi}; echo $${ORG})


APP_PORT=""


.PHONY: clean-install-user-group-automate  ## @-> setup the whole local devops environment no cache
clean-install-user-group-automate:
	$(call build-img,user-group-automate,--no-cache,${APP_PORT})
	make start-user-group-automate

.PHONY: install-user-group-automate  ## @-> setup the whole local devops environment
install-user-group-automate:
	$(call build-img,user-group-automate,,${APP_PORT})
	make start-user-group-automate

.PHONY: start-user-group-automate  ## @-> setup the whole local user-group-automate environment for python no cache
start-user-group-automate:
	$(call start-img,user-group-automate,--no-cache,${APP_PORT})
