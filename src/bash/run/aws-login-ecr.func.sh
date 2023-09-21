#!/usr/bin/env bash

do_aws_login_ecr() {

    APP=${APP:?}
    ORG=${ORG:-"spe"}
    # By default infra-app branches will always have ECR on all account
    ENV=${ENV:-"all"}; if [[ "${ENV}" == "lde" ]]; then ENV=all; fi

    oae_profile=""${ORG}_${APP}_${ENV}_rcr
    AWS_PROFILE=${AWS_PROFILE:-$oae_profile}
    AWS_REGION=${AWS_REGION:-"us-east-1"}

    account_id=$(aws sts get-caller-identity --profile spe_nba_dev_rcr --output json | jq -c '.Account'|sed s/\"//g)
    registry_url="${account_id}.dkr.ecr.us-east-1.amazonaws.com"

    do_log INFO Logging in to registry ${registry_url}
    do_log INFO AWS_PROFILE = ${oae_profile}
    aws ecr get-login-password --region ${AWS_REGION} --profile ${AWS_PROFILE} | docker login --username AWS --password-stdin ${registry_url}

    rv=$? ; test $rv == "0" && export exit_code=0
}
