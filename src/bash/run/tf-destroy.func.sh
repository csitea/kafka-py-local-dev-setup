#!/usr/bin/env bash
#
# The terraform destroy command is a convenient way to destroy all remote objects managed by a particular Terraform configuration.
# https://developer.hashicorp.com/terraform/cli/commands/destroy
#

do_tf_destroy() {

  do_log "INFO START ::: tf_destroy for step ${STEP}"

  do_tf_header

  # do_backup_region_dynamo_db_tables "$AWS_PROFILE" "$AWS_REGION"

  vars_path="$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV/tf/$tf_proj.vars.tfvars"
  backend_config_path="$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV/tf/$tf_proj.backend-config.tfvars"

  set -e

  echo "running: do_tf_destroy in 5 seconds"
  set -x
  sleep 5
  terraform -chdir=$bin_dir init -backend-config=$backend_config_path -upgrade
  terraform -chdir=$bin_dir destroy -var-file=$vars_path -auto-approve -lock=false
  set +x

  do_log "INFO STOP  ::: tf_destroy for step $tf_proj"
  set +e
  export exit_code=0

}
