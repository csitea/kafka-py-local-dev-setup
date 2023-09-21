#!/bin/bash
do_infra_spindown(){
    do_log "WARNING You're about to provision a full cloud environment for:"
    do_log "WARNING Organization: ${ORG}"
    do_log "WARNING Application:  ${APP}"
    do_log "WARNING Environment:  ${ENV}"

    do_log "INFO Divesting will start in 5 seconds ..."
    sleep 5

    ACTION=divest

    # this step is quick, after this all can be done in parallel
    ORG=${ORG} APP=${APP} ENV=${ENV} make do-${ACTION}-070-coupling

    do_infra_run ${ACTION} 020-rds &
    do_infra_run ${ACTION} 030-eks &
    do_infra_run ${ACTION} 050-wireguard &
    
    export exit_code=0
}

