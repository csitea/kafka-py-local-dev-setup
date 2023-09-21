#!/bin/bash

# src: https://stackoverflow.com/a/69905254/65706
# this is supposed to be onetime operation - hence the bad configurability !!!
# call-by :
# AWS_PROFILE=log_profile AWS_REGION=us-east-1 ./run -a do_copy_ecr_data
# you need to have also the following aws creds
# cat << EOF >> ~/.aws/credentials
# # Assume role all_iam_role_root_admin on logging from master rtr_adm sess
# [spe_nba_all_idy]
# SRC_AWS_PROFILE = rtr_adm_sess
# role_arn = arn:aws:iam::831036286708:role/all_iam_role_root_admin
# role_session_name = spe_nba_all_log_sess
# region = us-east-1
# Assume role OrganizationAccountAdminAccess on logging from master
# [log_profile]
# source_profile = master_session_profile
# role_arn = arn:aws:iam::386351740899:role/OrganizationAccountAdminAccess
# role_session_name = logging_OrganizationAccountAdminAccess_yordan.georgiev@value
# region = us-east-1
# EOF
do_copy_ecr_data(){

  set -e

  ################################# UPDATE THESE #################################
  LAST_N_TAGS=10

  SRC_AWS_REGION="us-east-1"
  TGT_AWS_REGION="us-east-1"

  SRC_AWS_PROFILE="src"
  TGT_AWS_PROFILE="tgt"

  SRC_BASE_PATH="386351740899.dkr.ecr.$SRC_AWS_REGION.amazonaws.com"
  TGT_BASE_PATH="036749602915.dkr.ecr.$TGT_AWS_REGION.amazonaws.com"
  #################################################################################

  URI=($(aws ecr describe-repositories --profile $SRC_AWS_PROFILE --query 'repositories[].repositoryUri' --output text --region $SRC_AWS_REGION))
  NAME=($(aws ecr describe-repositories  --profile $SRC_AWS_PROFILE --query 'repositories[].repositoryName' --output text --region $SRC_AWS_REGION))

  echo "Start repo copy: `date`"

  # source account login
  aws --profile $SRC_AWS_PROFILE --region $SRC_AWS_REGION ecr get-login-password | docker login --username AWS --password-stdin $SRC_BASE_PATH

  # destination account login
  aws --profile $TGT_AWS_PROFILE --region $TGT_AWS_REGION ecr get-login-password | docker login --username AWS --password-stdin $TGT_BASE_PATH


  for i in ${!URI[@]}; do
    echo "====> Grabbing latest $LAST_N_TAGS from ${NAME[$i]} repo"
    # create ecr repo if one does not exist in destination account
    # aws ecr describe-repositories --repository-names ${NAME[$i]} || aws ecr create-repository --repository-name ${NAME[$i]}

    for tag in $(aws ecr describe-images --repository-name ${NAME[$i]} \
      --query 'sort_by(imageDetails,& imagePushedAt)[*]' \
      --filter tagStatus=TAGGED --output text \
      | grep IMAGETAGS | awk '{print $2}' | tail -$LAST_N_TAGS); do

      # if [[ ${NAME[$i]} == "spectralha-api/frontend-nba" ]]; then
      #   continue
      # fi
      # # 386351740899.dkr.ecr.us-east-1.amazonaws.com/spectralha-api/white-ref-detector
      # if [[ ${NAME[$i]} == "386351740899.dkr.ecr.us-east-1.amazonaws.com/spectralha-api/white-ref-detector" ]]; then
      #   continue
      # fi


      echo "START ::: pulling image ${URI[$i]}:$tag" >> src/bash/scripts/copy-ecr.sh
      echo AWS_REGION=$SRC_AWS_REGION AWS_PROFILE=$SRC_AWS_PROFILE docker pull ${URI[$i]}:$tag >> src/bash/scripts/copy-ecr.sh
      echo AWS_REGION=$SRC_AWS_REGION AWS_PROFILE=$SRC_AWS_PROFILE docker tag ${URI[$i]}:$tag $TGT_BASE_PATH/${NAME[$i]}:$tag >> src/bash/scripts/copy-ecr.sh
      echo "STOP  ::: pulling image ${URI[$i]}:$tag" >> src/bash/scripts/copy-ecr.sh

      echo "START ::: pushing image $TGT_BASE_PATH/${NAME[$i]}:$tag" >> src/bash/scripts/copy-ecr.sh
      # status=$(AWS_REGION=$TGT_AWS_REGION AWS_PROFILE=$TGT_AWS_PROFILE docker push $TGT_BASE_PATH/${NAME[$i]}:$tag)
      # echo $status
      echo AWS_REGION=$TGT_AWS_REGION AWS_PROFILE=$TGT_AWS_PROFILE docker push $TGT_BASE_PATH/${NAME[$i]}:$tag >> src/bash/scripts/copy-ecr.sh
      echo "STOP ::: pushing image $TGT_BASE_PATH/${NAME[$i]}:$tag" >> src/bash/scripts/copy-ecr.sh
      # cd /opt/spe/infra && make do-prune-docker-system && cd -
      do_flush_screen
      echo ""
    done
  done

  echo "Finish repo copy: `date`"
  echo "Don't forget to purge you local docker images!"
  #Uncomment to delete all
  #docker rmi $(for i in ${!NAME[@]}; do docker images | grep ${NAME[$i]} | tr -s ' ' | cut -d ' ' -f 3 | uniq; done) -f
  #

  export exit_code="0"
}
