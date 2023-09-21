#!/usr/bin/env bash

do_tf_apply(){
# Terraform apply for provision using remote state.

  do_simple_log "INFO START ::: provisioning step ${STEP}"

  do_tf_header

  # do_backup_region_dynamo_db_tables "$AWS_PROFILE" "$AWS_REGION"

  vars_path="$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV/tf/$tf_proj.vars.tfvars"
  backend_config_path="$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV/tf/$tf_proj.backend-config.tfvars"

  do_log "INFO running:
  terraform -chdir=${bin_dir} init -backend-config=$backend_config_path -upgrade"

  do_log "INFO running:
  terraform -chdir=${bin_dir} apply -var-file=$vars_path -auto-approve -lock=false"


  set -e ; set -x
  # jump-init
  terraform -chdir=${bin_dir} init -backend-config=$backend_config_path -upgrade
  #env | sort
  terraform -chdir=${bin_dir} apply -var-file=$vars_path -auto-approve -lock=false
  set +x ; set +e

  # jump-init
  # rm -rf ${bin_dir} # && rm -rf ${modules_tgt_dir}

  do_simple_log "INFO STOP  ::: provisioning step ${tf_proj}"

}
