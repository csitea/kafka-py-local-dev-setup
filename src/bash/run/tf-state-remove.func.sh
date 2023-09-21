#!/usr/bin/env bash

do_tf_state_remove(){

  do_log "INFO START ::: provisioning step ${tf_proj}"

  TARGET=${TARGET:?}

  do_tf_header
  
  # do_backup_region_dynamo_db_tables "$AWS_PROFILE" "$AWS_REGION"

  vars_path="$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV/tf/$tf_proj.vars.tfvars"
  backend_config_path="$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV/tf/$tf_proj.backend-config.tfvars"

  set -e

  echo "running: "
  set -x

  terraform -chdir=${bin_dir} init -backend-config=$backend_config_path -upgrade

  while IFS=',' read -ra TARGETS; do
    for target in "${TARGETS[@]}"; do
      terraform -chdir=${bin_dir} get -update=true && terraform -chdir=${bin_dir} state rm -lock=false ${target}
    done
  done <<< "$TARGET"

  rm -rf ${bin_dir} #&& rm -rf ${modules_tgt_dir}

  set +x
  set +e

  do_simple_log "INFO STOP  ::: provisioning step ${tf_proj}"
  export exit_code=0

}
