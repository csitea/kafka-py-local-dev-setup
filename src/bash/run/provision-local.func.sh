#!/usr/bin/env bash

do_provision_local() {

  do_tf_header


  do_tf_apply_local "${STEP}"

  rv=$? ; test $rv == "0" && export exit_code=0
}
