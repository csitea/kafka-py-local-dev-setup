

.PHONY: do-provision- ## @-> run the provision step 
do-provision-: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP= -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest- ## @-> run the divest step 
do-divest-: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP= -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision

.PHONY: do-provision-002-aws-accounts ## @-> run the provision step 002-aws-accounts
do-provision-002-aws-accounts: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=002-aws-accounts -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-002-aws-accounts ## @-> run the divest step 002-aws-accounts
do-divest-002-aws-accounts: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=002-aws-accounts -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision
# found action: 002-aws-accounts already - nothing to do

.PHONY: do-provision-003-aws-scps ## @-> run the provision step 003-aws-scps
do-provision-003-aws-scps: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=003-aws-scps -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-003-aws-scps ## @-> run the divest step 003-aws-scps
do-divest-003-aws-scps: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=003-aws-scps -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision
# found action: 003-aws-scps already - nothing to do

.PHONY: do-provision-004-aws-iam ## @-> run the provision step 004-aws-iam
do-provision-004-aws-iam: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=004-aws-iam -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-004-aws-iam ## @-> run the divest step 004-aws-iam
do-divest-004-aws-iam: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=004-aws-iam -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision
# found action: 004-aws-iam already - nothing to do

.PHONY: do-provision-005-sys-users ## @-> run the provision step 005-sys-users
do-provision-005-sys-users: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=005-sys-users -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-005-sys-users ## @-> run the divest step 005-sys-users
do-divest-005-sys-users: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=005-sys-users -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision
# found action: 005-sys-users already - nothing to do

.PHONY: do-provision-006-individual-users ## @-> run the provision step 006-individual-users
do-provision-006-individual-users: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=006-individual-users -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-006-individual-users ## @-> run the divest step 006-individual-users
do-divest-006-individual-users: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=006-individual-users -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision
# found action: 006-individual-users already - nothing to do

.PHONY: do-provision-007-dns ## @-> run the provision step 007-dns
do-provision-007-dns: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=007-dns -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-007-dns ## @-> run the divest step 007-dns
do-divest-007-dns: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=007-dns -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision
# found action: 007-dns already - nothing to do

.PHONY: do-provision-008-ecr ## @-> run the provision step 008-ecr
do-provision-008-ecr: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=008-ecr -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-008-ecr ## @-> run the divest step 008-ecr
do-divest-008-ecr: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=008-ecr -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision
# found action: 008-ecr already - nothing to do

.PHONY: do-provision-009-budgets ## @-> run the provision step 009-budgets
do-provision-009-budgets: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=009-budgets -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-009-budgets ## @-> run the divest step 009-budgets
do-divest-009-budgets: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=009-budgets -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision
# found action: 009-budgets already - nothing to do

.PHONY: do-provision-010-static-sites ## @-> run the provision step 010-static-sites
do-provision-010-static-sites: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=010-static-sites -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-010-static-sites ## @-> run the divest step 010-static-sites
do-divest-010-static-sites: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=010-static-sites -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision
# found action: 010-static-sites already - nothing to do

.PHONY: do-provision-011-static-sites ## @-> run the provision step 011-static-sites
do-provision-011-static-sites: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=011-static-sites -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-011-static-sites ## @-> run the divest step 011-static-sites
do-divest-011-static-sites: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=011-static-sites -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision
# found action: 011-static-sites already - nothing to do

.PHONY: do-provision-012-static-sites ## @-> run the provision step 012-static-sites
do-provision-012-static-sites: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=012-static-sites -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-012-static-sites ## @-> run the divest step 012-static-sites
do-divest-012-static-sites: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=012-static-sites -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision
# found action: 012-static-sites already - nothing to do

.PHONY: do-provision-013-sbss-infra-mon ## @-> run the provision step 013-sbss-infra-mon
do-provision-013-sbss-infra-mon: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=013-sbss-infra-mon -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-013-sbss-infra-mon ## @-> run the divest step 013-sbss-infra-mon
do-divest-013-sbss-infra-mon: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=013-sbss-infra-mon -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision

.PHONY: do-provision-013-static-sites ## @-> run the provision step 013-static-sites
do-provision-013-static-sites: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=013-static-sites -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-013-static-sites ## @-> run the divest step 013-static-sites
do-divest-013-static-sites: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=013-static-sites -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision

.PHONY: do-provision-015-s3-buckets ## @-> run the provision step 015-s3-buckets
do-provision-015-s3-buckets: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=015-s3-buckets -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-015-s3-buckets ## @-> run the divest step 015-s3-buckets
do-divest-015-s3-buckets: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=015-s3-buckets -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision
# found action: 015-s3-buckets already - nothing to do

.PHONY: do-provision-020-rds ## @-> run the provision step 020-rds
do-provision-020-rds: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=020-rds -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-020-rds ## @-> run the divest step 020-rds
do-divest-020-rds: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=020-rds -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision
# found action: 020-rds already - nothing to do

.PHONY: do-provision-021-rds-creds ## @-> run the provision step 021-rds-creds
do-provision-021-rds-creds: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=021-rds-creds -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-021-rds-creds ## @-> run the divest step 021-rds-creds
do-divest-021-rds-creds: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=021-rds-creds -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision
# found action: 021-rds-creds already - nothing to do

.PHONY: do-provision-030-eks ## @-> run the provision step 030-eks
do-provision-030-eks: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=030-eks -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-030-eks ## @-> run the divest step 030-eks
do-divest-030-eks: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=030-eks -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision
# found action: 030-eks already - nothing to do

.PHONY: do-provision-033-jenkins-x ## @-> run the provision step 033-jenkins-x
do-provision-033-jenkins-x: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=033-jenkins-x -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-033-jenkins-x ## @-> run the divest step 033-jenkins-x
do-divest-033-jenkins-x: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=033-jenkins-x -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision
# found action: 033-jenkins-x already - nothing to do

.PHONY: do-provision-035-cloudflare-facade ## @-> run the provision step 035-cloudflare-facade
do-provision-035-cloudflare-facade: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=035-cloudflare-facade -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-035-cloudflare-facade ## @-> run the divest step 035-cloudflare-facade
do-divest-035-cloudflare-facade: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=035-cloudflare-facade -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision
# found action: 035-cloudflare-facade already - nothing to do

.PHONY: do-provision-040-jenkins ## @-> run the provision step 040-jenkins
do-provision-040-jenkins: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=040-jenkins -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-040-jenkins ## @-> run the divest step 040-jenkins
do-divest-040-jenkins: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=040-jenkins -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision
# found action: 040-jenkins already - nothing to do

.PHONY: do-provision-050-wireguard ## @-> run the provision step 050-wireguard
do-provision-050-wireguard: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=050-wireguard -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-050-wireguard ## @-> run the divest step 050-wireguard
do-divest-050-wireguard: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=050-wireguard -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision
# found action: 050-wireguard already - nothing to do

.PHONY: do-provision-051-splunk ## @-> run the provision step 051-splunk
do-provision-051-splunk: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=051-splunk -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-051-splunk ## @-> run the divest step 051-splunk
do-divest-051-splunk: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=051-splunk -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision
# found action: 051-splunk already - nothing to do

.PHONY: do-provision-053-infra-monitor ## @-> run the provision step 053-infra-monitor
do-provision-053-infra-monitor: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=053-infra-monitor -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-053-infra-monitor ## @-> run the divest step 053-infra-monitor
do-divest-053-infra-monitor: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=053-infra-monitor -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision

.PHONY: do-provision-060-location-service ## @-> run the provision step 060-location-service
do-provision-060-location-service: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=060-location-service -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-060-location-service ## @-> run the divest step 060-location-service
do-divest-060-location-service: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=060-location-service -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision
# found action: 060-location-service already - nothing to do

.PHONY: do-provision-065-sns-topics ## @-> run the provision step 065-sns-topics
do-provision-065-sns-topics: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=065-sns-topics -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-065-sns-topics ## @-> run the divest step 065-sns-topics
do-divest-065-sns-topics: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=065-sns-topics -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision
# found action: 065-sns-topics already - nothing to do

.PHONY: do-provision-070-coupling ## @-> run the provision step 070-coupling
do-provision-070-coupling: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=070-coupling -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-070-coupling ## @-> run the divest step 070-coupling
do-divest-070-coupling: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=070-coupling -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision
# found action: 070-coupling already - nothing to do

.PHONY: do-provision-071-init-cnf-creds ## @-> run the provision step 071-init-cnf-creds
do-provision-071-init-cnf-creds: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=071-init-cnf-creds -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-071-init-cnf-creds ## @-> run the divest step 071-init-cnf-creds
do-divest-071-init-cnf-creds: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=071-init-cnf-creds -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision

.PHONY: do-provision-072-sync-cnf-creds ## @-> run the provision step 072-sync-cnf-creds
do-provision-072-sync-cnf-creds: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=072-sync-cnf-creds -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-072-sync-cnf-creds ## @-> run the divest step 072-sync-cnf-creds
do-divest-072-sync-cnf-creds: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=072-sync-cnf-creds -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision

.PHONY: do-provision-073-coupling-creds ## @-> run the provision step 073-coupling-creds
do-provision-073-coupling-creds: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=073-coupling-creds -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-073-coupling-creds ## @-> run the divest step 073-coupling-creds
do-divest-073-coupling-creds: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=073-coupling-creds -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision

.PHONY: do-provision-999-quick-test ## @-> run the provision step 999-quick-test
do-provision-999-quick-test: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=999-quick-test -e ACTION=provision -e SRC=/var/$(ORG)/$(ORG)-infra-conf -e TGT=/var/$(ORG)/$(ORG)-infra-conf $(PRODUCT)-tf-runner-con ./run -a do_provision


.PHONY: do-divest-999-quick-test ## @-> run the divest step 999-quick-test
do-divest-999-quick-test: demand_var-ENV demand_var-ORG demand_var-APP
	docker exec -e ORG=$(ORG) -e APP=$(APP) -e ENV=$(ENV) -e STEP=999-quick-test -e ACTION=divest $(PRODUCT)-tf-runner-con ./run -a do_provision
