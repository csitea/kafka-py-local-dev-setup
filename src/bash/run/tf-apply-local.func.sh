#!/usr/bin/env bash
# Terraform apply for provision using local state.
do_tf_apply_local() {

  do_tf_header

  tf_path="$PRODUCT_DIR/src/terraform/$STEP"
  # we agree that only s3 states are provisioned locally, any state that is
  # more complex than this should live in an s3.
  test -d ${bin_dir} && rm -r ${bin_dir} # done in the tf_header as well
  cp -r ${tf_path} ${bin_dir}


  JSON_ENV_FILE="$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV.env.json"
  do_export_json_section_vars "$JSON_ENV_FILE" ".env.aws"
  do_export_json_section_vars "$JSON_ENV_FILE" '.env.steps."'${STEP}'"'



  do_log "INFO STEP: ${STEP}"
  do_log "WARNING AWS_PROFILE: ${AWS_PROFILE}"
  do_log "WARNING AWS_SHARED_CREDENTIALS_FILE: ${AWS_SHARED_CREDENTIALS_FILE}"
  do_log "WARNING AWS_REGION: ${AWS_REGION}"

  # do_backup_region_dynamo_db_tables "$AWS_PROFILE" "$AWS_REGION"

  tf_vars_file="$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV/tf/$STEP.vars.tfvars"
  #          cnf/env/tqa/wwh/prd/tf/032-hetzner-plesk-server.vars.tfvars
  # cnf/env/spe/sew/dev/tf/011-static-sites-remote-bucket.vars.tfvars

  ts=$( date "+%Y%m%d_%H%M%S")
  state_path_to_load="$PRODUCT_DIR/cnf/terraform/$STEP/$ORG.$APP.$ENV.tfstate"
  mkdir -p "$PRODUCT_DIR/cnf/terraform/$STEP/" || true
  state_path_bak="$PRODUCT_DIR/dat/terraform/${STEP}/terraform.$ts.bak.tfstate"
  state_path="${bin_dir}/terraform.tfstate"

  # load the RIGHT previous local state
  test -f "$state_path" && rm -v "$state_path"
  test -d "$PRODUCT_DIR/cnf/terraform/$STEP" || mkdir -p "cnf/terraform/$STEP"
  test -f "$state_path_to_load" && yes | cp "$state_path_to_load" "$state_path"

  do_log "INFO running:
  terraform -chdir=${bin_dir} apply -var-file=$tf_vars_file -auto-approve
  "
  #env | sort
  set -x
  terraform -chdir=${bin_dir} init -upgrade
  # todo -- verify thar if apply is left uncompleted ... after apply loads the state
  test -f "$state_path_to_load" && yes | cp "$state_path_to_load" "$state_path"
  terraform -chdir=${bin_dir} apply -var-file=$tf_vars_file -auto-approve
  # removing this here prevents the state from being copied
  # although losing state-bucket state is not fatal, we must
  # assure states are being copied. Remote applies continue
  # to remove this folder.
  #  && rm -rf ${modules_tgt_dir}
  set +x

  # save the applied local state
  test -n "${state_path_bak}" && mkdir -p "$(dirname "${state_path_bak:-}")" || true
  test -f "$state_path_to_load" && cp "$state_path_to_load" "$state_path_bak"
  test -f "$state_path" && cp "$state_path" "$state_path_to_load"

}
