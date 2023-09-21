#!/usr/bin/env bash

do_divest_local() {

  do_tf_header

  do_log "INFO running checking the bucket by"
  do_log "INFO AWS_SHARED_CREDENTIALS_FILE: ${AWS_SHARED_CREDENTIALS_FILE}"


  # divest
  do_tf_destroy_local "${STEP}"

  rv=$? ; test $rv == "0" && export exit_code=0
}
