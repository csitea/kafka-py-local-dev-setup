#!/usr/bin/env bash
# Terraform apply for provision using local state.
do_tf_apply_local_step_bucket() {

  do_tf_header

  # for do_tf_local_apply $tf_proj is evaluated as step-remote-bucket
  main_step=${tf_proj//-remote-bucket//}
  tf_path="$PRODUCT_DIR/src/terraform/$tf_proj"'-remote-bucket'
  # we agree that only s3 states are provisioned locally, any state that is
  # more complex than this should live in an s3.
  bin_dir="$bin_dir"'-remote-bucket'
  test -d ${bin_dir} && rm -r ${bin_dir}
  mkdir -p ${PRODUCT_DIR}/bin/${ORG}/${APP}/${ENV}
  cp -r ${tf_path} ${bin_dir}


  JSON_ENV_FILE="$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV.env.json"
  do_export_json_section_vars "$JSON_ENV_FILE" ".env.aws"
  do_export_json_section_vars "$JSON_ENV_FILE" '.env.steps."'${main_step}'"'
  do_export_json_section_vars "$JSON_ENV_FILE" '.env.steps."'${tf_proj}'"'


  do_log "INFO tf_proj: ${main_step}"
  do_log "WARNING AWS_PROFILE: ${AWS_PROFILE}"
  do_log "WARNING AWS_SHARED_CREDENTIALS_FILE: ${AWS_SHARED_CREDENTIALS_FILE}"
  do_log "WARNING AWS_REGION: ${AWS_REGION}"

  # do_backup_region_dynamo_db_tables "$AWS_PROFILE" "$AWS_REGION"

  tf_vars_file="$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV/tf/$tf_proj-remote-bucket.vars.tfvars"
  # cnf/env/spe/sew/dev/tf/011-static-sites-remote-bucket.vars.tfvars

  ts=$( date "+%Y%m%d_%H%M%S")
  state_path_to_load="$PRODUCT_DIR/cnf/terraform/$tf_proj/$ORG.$APP.$ENV.tfstate"
  state_path_bak="$PRODUCT_DIR/dat/terraform/${tf_proj}/terraform.$ts.bak.tfstate"
  #state_path="$PRODUCT_DIR/src/terraform/$tf_proj/terraform.tfstate"
  state_path="${bin_dir}/terraform.tfstate"

  # load the RIGHT previous local state
  test -f "$state_path" && rm -v "$state_path"
  test -d "cnf/terraform/$tf_proj" || mkdir -p "cnf/terraform/$tf_proj"
  test -f "$state_path_to_load" && yes | cp "$state_path_to_load" "$state_path"

  do_log "INFO running:
  terraform -chdir=${bin_dir} apply -var-file=$tf_vars_file -auto-approve"
  #env | sort
  set -e; set -x
  terraform -chdir=${bin_dir} init -upgrade
  terraform -chdir=${bin_dir} apply -var-file=$tf_vars_file -auto-approve
  # removing this here prevents the state from being copied
  # although losing state-bucket state is not fatal, we must
  # assure states are being copied. Remote applies continue
  # to remove this folder.
  #  && rm -rf ${modules_tgt_dir}
  set +x ; set +e

  # save the applied local state
  mkdir -p "$(dirname "${state_path_bak:-}")"
  test -f "$state_path_to_load" && cp "$state_path_to_load" "$state_path_bak"
  test -f "$state_path" && cp "$state_path" "$state_path_to_load"

}
