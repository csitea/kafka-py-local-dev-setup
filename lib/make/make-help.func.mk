# usage: include it in your Makefile
# include lib/make/make-help.task

.DEFAULT_GOAL := help

.PHONY: help  ## @-> show this help  the default action
help:
	# @clear
	@fgrep -h "##" $(MAKEFILE_LIST)|fgrep -v fgrep|sed -e 's/^\.PHONY: //'|sed -e 's/^\(.*\)##/\1/'| \
      column -t -s $$'@'

.PHONY: tf-help  ## @-> show this help  the default action
tf-help:
	# @clear
	while read -r step ; do echo 'clear;export STEP='$$step'; ORG=spe APP=prp ENV=env make do-provision-$$STEP | tee -a 2>&1 ~/Desktop/$$ORG.$$APP.$$ENV.$$STEP.log' ; done < <(ls -1 src/terraform/ | grep -v bucket)| column -t

.PHONY: oae-tf-help-provision  ## @-> show this help  the default action
oae-tf-help-provision:
	# @clear
	$(call demand-var,ORG)
	$(call demand-var,APP)
	$(call demand-var,ENV)
	while read -r step ; do echo 'clear;export STEP='$$step'; ORG=$(ORG) APP=$(APP) ENV=$(ENV) make do-provision-$$STEP | tee -a 2>&1 ~/Desktop/$$ORG.$$APP.$$ENV.$$STEP.log' ; done < <(ls -1 src/terraform/ | grep -v bucket)| column -t

.PHONY: oae-tf-help-divest  ## @-> show this help  the default action
oae-tf-help-divest:
	# @clear
	$(call demand-var,ORG)
	$(call demand-var,APP)
	$(call demand-var,ENV)
	while read -r step ; do echo 'clear;export STEP='$$step'; ORG=$(ORG) APP=$(APP) ENV=$(ENV) make do-divest-$$STEP | tee -a 2>&1 ~/Desktop/$$ORG.$$APP.$$ENV.$$STEP.log' ; done < <(ls -1 src/terraform/ | grep -v bucket)| column -t
