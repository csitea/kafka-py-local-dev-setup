#!/usr/bin/env bash

do_provision() {

  do_tf_header

  # TODO: spe-2212231328
  # the state bucket name OR it's naming convention should be fetched from the conf
  # and not built dynamically in the different runtmes ...
  bucket=${STATE_BUCKET:-}

  do_log "INFO using the following state bucket: $bucket"
  # test -z $bucket && bucket="${ORG}-${APP}-${ENV}.${STEP}-remote-bucket.terraform-state"
  s3_exists=$(aws s3 --profile $AWS_PROFILE ls | grep -c "$bucket"|xargs)

  do_log "INFO running checking the bucket by"
  do_log "INFO AWS_SHARED_CREDENTIALS_FILE: ${AWS_SHARED_CREDENTIALS_FILE}"
  do_log "INFO s3_exists: ${s3_exists}"
  do_log "INFO bucket_name: ${bucket}"


  if [[ "${ACTION}" == "divest" ]]; then
    # divest
    if [[ $s3_exists -eq 1 ]]; then
      do_tf_destroy "${STEP}"

      # As agreed in 2207291920 :::
      # Remote buckets will be provisioned and remain in the account until further notice.
      # This allows us to keep a single version of tfstate through the code, and enjoy
      # all the functionalities s3 state storing provides, without breaking states or
      # being locked by AWS console/cli caching.
      do_log "INFO 2207291920 ::: remote buckets need to be manually removed"
      echo do_tf_destroy_local_step_bucket "${STEP}-remote-bucket"
    fi
  else
    # provision by default
    if [[ $s3_exists -eq 0 ]]; then
      do_tf_apply_local_step_bucket "${STEP}-remote-bucket"
    fi
    do_tf_apply "${STEP}"
  fi

  rv=$? ; test $rv == "0" && export exit_code=0
}
