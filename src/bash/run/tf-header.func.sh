#!/usr/bin/env bash
# This function requires all variables necessary for basic
# terraform and steps. Any time you need extra variables,
# add the logic outside this file and leave here only the
# core variables.
do_tf_header() {
    tf_proj=${STEP:?}
    tgt_app=${APP:?}

    do_require_var ORG  "${ORG:-}"
    do_require_var APP  "${APP:-}"
    do_require_var ENV  "${ENV:-}"
    do_require_var STEP "${STEP:-}"
    do_require_var ACTION "${ACTION:-provision}"  # fail safe, never destroy if something breaks

    default_early_credentials_file="$HOME/.aws/.$ORG/$ORG-$APP.early-credentials.json"
    EARLY_CREDENTIALS_FILE="${EARLY_CREDENTIALS_FILE:-$default_early_credentials_file}"
    do_log INFO EARLY_CREDENTIALS_FILE: ${EARLY_CREDENTIALS_FILE}

    do_export_json_section_vars "$EARLY_CREDENTIALS_FILE" "." "sensitive-values"
    eval export GITHUB_OWNER_ORG="\${${ORG^^}_GITHUB_OWNER_ORG:-}"
    do_log INFO GITHUB_OWNER_ORG: ${GITHUB_OWNER_ORG}

    # -o StrictHostKeyChecking=no
    export GIT_SSH_COMMAND="ssh -p 22 -i ~/.ssh/.$ORG/id_rsa.$ORG";

    eval export TF_VAR_product_dir="${PRODUCT_DIR}"
    eval export TF_VAR_base_dir="${BASE_DIR}"
    eval export TF_VAR_org_dir="${ORG_DIR}"

    # Either to skip git clone on infra-core
    # useful to debug / troubleshoot without tainting the git history

    PRODUCT_CONF_DIR="$PRODUCT_DIR/cnf/env/$ORG/"
    SKIP_GIT_CLONE=${SKIP_GIT_CLONE:-false}
    do_log INFO SKIP_GIT_CLONE: ${SKIP_GIT_CLONE}
    sleep 3
    if [[ "${SKIP_GIT_CLONE}" != "true" ]]; then
        test -d "${PRODUCT_CONF_DIR:-}" && echo "rm -r $PRODUCT_CONF_DIR" && sudo rm -rf "$PRODUCT_CONF_DIR"
        git clone -b master --single-branch "git@github.com:$GITHUB_OWNER_ORG/$ORG-$APP-infra-conf.git" "$PRODUCT_CONF_DIR"
        sleep 3
    else
        echo "Skipping git clone "
    fi


    do_export_json_section_vars "$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV.env.json" ".env.aws"
    do_export_json_section_vars "$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV.env.json" ".env.versions"
    do_export_json_section_vars "$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV.env.json" '.env.steps."'${STEP}'"'
    echo TERRAFORM_VERSION: $TERRAFORM_VERSION
    echo INFRA_VERSION: $INFRA_VERSION
    sleep 3

    # # note: depends on the convention that git_email = user_name is aws ...
    # export TF_VAR_git_user_email=$(AWS_SHARED_CREDENTIALS_FILE=$AWS_SHARED_CREDENTIALS_FILE aws sts get-caller-identity --profile $AWS_PROFILE|grep -i arn|cut -d/ -f2|sed -e 's/"//g')
    # used for tagging cloud resources
    export TF_VAR_TERRAFORM_VERSION=${TERRAFORM_VERSION}
    export TF_VAR_INFRA_VERSION=${INFRA_VERSION}
    export TF_VAR_CNF_VER="$(git rev-parse --short HEAD)"  # 2210062011 ::: short hash instead of subjective config version
    export TF_VAR_STEP=${STEP:-}

    source "$BASE_DIR/$ORG_DIR/$ORG-$APP-infra-app/src/bash/scripts/set-$ORG-$APP-early-creds.sh"


    export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
    test -d "$TF_PLUGIN_CACHE_DIR" || mkdir -p "$TF_PLUGIN_CACHE_DIR"

    tfswitch ${TERRAFORM_VERSION}

    tf_path="$PRODUCT_DIR/src/terraform/$tf_proj"
    # 220729 ::: to allow multiple terraform calls in a single container
    #test -d "$tf_path/.terraform" &&
    #  rm -vr "$tf_path/.terraform"
    export bin_dir=${PRODUCT_DIR}/bin/${ORG}/${APP}/${ENV}/${tf_proj}

    test -d ${bin_dir} && rm -r ${bin_dir}
    #test -d ${modules_tgt_dir} && rm -vr ${modules_tgt_dir}

    mkdir -p ${PRODUCT_DIR}/bin/${ORG}/${APP}/${ENV}
    cp -r ${tf_path} ${bin_dir}

    md5modules_bin=`find ${bin_dir}/../modules -type f -exec md5sum {} \; | md5sum`
    md5modules=`find ${tf_path}/../modules -type f -exec md5sum {} \; | md5sum`

    # if they're not equal, the copy again
    if [[ "${md5modules_bin}" == "${md5modules}" ]]; then
    do_log "INFO modules folder MD5 is consistent: ${md5modules}"
    do_log "INFO sync is not needed"
    else
    do_log "WARNING modules folder MD5 diverged: ${md5modules_bin} -- ${md5modules}"
    do_log "INFO copying ${tf_path} to ${bin_dir}"
    rm -rf "${bin_dir}/../modules" && cp -r "${tf_path}/../modules" "${bin_dir}/../"
    fi

    do_log "INFO copying ${tf_path} to ${bin_dir}"

    test -z "${AWS_PROFILE:-}" && export AWS_PROFILE="rtr_adm"
    test -z "${AWS_REGION:-}" && export AWS_REGION="us-east-1"

}
