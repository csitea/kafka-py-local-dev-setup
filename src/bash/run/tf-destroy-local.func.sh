#!/usr/bin/env bash
# Terraform destroy for provision using local state.
do_tf_destroy_local() {

  do_log "INFO START ::: tf_destroy_local_bare for STEP ${STEP}"

  do_tf_header

  # for do_tf_local_apply $STEP is evaluated as STEP-remote-bucket
  # we agree that only s3 states are provisioned locally, any state that is
  # more complex than this should live in an s3.

  do_export_json_section_vars "$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV.env.json" ".env.aws"
  do_export_json_section_vars "$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV.env.json" '.env.STEPs."'${STEP:-}'"'


  # /opt/tqa/tqa-wwh-infra-app/bin/tqa/wwh/tst/032-hetzner-plesk-server/terraform.tfstate.backup
  vars_path="$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV/tf/$STEP.vars.tfvars"

  ts=$( date "+%Y%m%d_%H%M%S")
  state_path_to_load="$PRODUCT_DIR/cnf/terraform/$STEP/$ORG.$APP.$ENV.tfstate"
  state_path="${bin_dir}/terraform.tfstate"

  # load the RIGHT previous local state
  test -f "$state_path" && rm -v "$state_path"
  test -d "cnf/terraform/$STEP" || mkdir -p "cnf/terraform/$STEP" || true
  #test -f "$state_path_to_load" && yes | cp -v "$state_path_to_load" "$state_path"

  echo "running: "
  set -e ; set -x
  terraform -chdir=$bin_dir init -upgrade
  test -f "$state_path_to_load" && yes | cp -v "$state_path_to_load" "$state_path" || true
  terraform -chdir=$bin_dir destroy -var-file=$vars_path -auto-approve
  set +x ; set +e

  # save the applied local state
  test -f "$state_path_to_load" && cp "$state_path_to_load" "${state_path_bak:-}"
  test -f "$state_path" && rm -v "$state_path"
  test -f $state_path_to_load && rm -v $state_path_to_load

  do_log "INFO STOP  ::: tf_destroy for STEP $STEP"

}
