#!/usr/bin/env bash
# Terraform destroy for provision using local state.
do_tf_destroy_local_step_bucket() {

  do_log "INFO START ::: tf_destroy for step ${STEP}"

  do_tf_header

  # for do_tf_local_apply $tf_proj is evaluated as step-remote-bucket
  main_step=`echo ${tf_proj} | sed s/-remote-bucket//g`
  # we agree that only s3 states are provisioned locally, any state that is
  # more complex than this should live in an s3.

  do_export_json_section_vars "$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV.env.json" ".env.aws"
  do_export_json_section_vars "$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV.env.json" '.env.steps."'${main_step}'"'
  #do_export_json_section_vars "$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV.env.json" '.env.steps."'${tf_proj}'"'

  # do_backup_region_dynamo_db_tables "$AWS_PROFILE" "$AWS_REGION"

  vars_path="$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV/tf/$tf_proj.vars.tfvars"

  ts=$( date "+%Y%m%d_%H%M%S")
  state_path_to_load="$PRODUCT_DIR/cnf/terraform/$tf_proj/$ORG.$APP.$ENV.tfstate"
  state_path_bak="$PRODUCT_DIR/dat/terraform/${tf_proj}/terraform.$ts.bak.tfstate"
  #state_path="$PRODUCT_DIR/src/terraform/$tf_proj/terraform.tfstate"
  state_path="${bin_dir}/terraform.tfstate"

  # load the RIGHT previous local state
  test -f "$state_path" && rm -v "$state_path"
  test -d "cnf/terraform/$tf_proj" || mkdir -p "cnf/terraform/$tf_proj" || true
  test -f "$state_path_to_load" && yes | cp "$state_path_to_load" "$state_path"

  set -e

  echo "running: "
  set -x
  terraform -chdir=$bin_dir init -upgrade
  terraform -chdir=$bin_dir destroy -var-file=$vars_path -auto-approve
  set +x

  set +e

  # save the applied local state
  test -f "$state_path_to_load" && cp "$state_path_to_load" "$state_path_bak"
  test -f "$state_path" && cp "$state_path" "$state_path_to_load"

  do_log "INFO STOP  ::: tf_destroy for step $tf_proj"

}
