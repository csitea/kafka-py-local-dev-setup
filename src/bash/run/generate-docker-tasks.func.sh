#!/bin/bash
do_generate_docker_tasks(){

   # bootstrap itself
   do_log "INFO generating docker provisioning tasks"
   echo '' > $PRODUCT_DIR/src/make/docker-provisoning-tasks.mk
   mkdir -p $PRODUCT_DIR/dat/tmp/
   test -f $PRODUCT_DIR/dat/tmp/.found-generate-docker-tasks && \
      rm -v $PRODUCT_DIR/dat/tmp/.found-generate-docker-tasks
   touch $PRODUCT_DIR/dat/tmp/.found-generate-docker-tasks

   while read -r action ; do
      if grep -Fxq "$action" $PRODUCT_DIR/dat/tmp/.found-generate-docker-tasks
        then
          echo \# found action: $action already - nothing to do
        else
        # code if not found
        cat lib/tpl/docker-task.mk | sed 's/%task%/'${action}'/g' 2> /dev/null
      fi
      echo $action >> $PRODUCT_DIR/dat/tmp/.found-generate-docker-tasks
   done < <(ls -1 $BASE_DIR/$ORG_DIR/*/src/terraform | egrep -v -e 'remote-bucket|modules'|sort -n) >> $PRODUCT_DIR/src/make/docker-provisoning-tasks.mk

   perl -pi -e 's|.PHONY|\n.PHONY|' src/make/docker-provisoning-tasks.mk

   export exit_code=0
}
