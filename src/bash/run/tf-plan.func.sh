#!/usr/bin/env bash

do_tf_plan(){

  do_log "INFO START ::: provisioning step ${STEP:?}"

  do_tf_header

  vars_path="$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV/tf/$tf_proj.vars.tfvars"
  backend_config_path="$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV/tf/$tf_proj.backend-config.tfvars"

  set -e

  echo "running: "
  set -x

  terraform -chdir=${bin_dir} init -backend-config=$backend_config_path -upgrade
  terraform -chdir=${bin_dir} plan -out=${ORG}-${APP}-${ENV}.tfplan -var-file=$vars_path -lock=false
  #terraform -chdir=${bin_dir} show -json ${ORG}-${APP}-${ENV}.tfplan | jq -r > ${ORG}-${APP}-${ENV}.tfplan
  #cat ${ORG}-${APP}-${ENV}.tfplan | jq -r '.planned_values.root_module.resources[].address'

  rm -rf ${bin_dir} #&& rm -rf ${modules_tgt_dir}
  set +x

  set +e

  do_simple_log "INFO STOP  ::: provisioning step ${tf_proj}"
  export exit_code=0

}
