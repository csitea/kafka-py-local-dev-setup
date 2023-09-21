#!/bin/env bash

do_aws_route53_state_backup() {
  # Define a directory for backups
  BACKUP_DIR="$PRODUCT_DIR/dat/json/$ORG/aws/root/route53-backups"
  mkdir -p $BACKUP_DIR

  do_require_var ORG "${ORG:-}"
  export AWS_SHARED_CREDENTIALS_FILE=~/.aws/.$ORG/credentials

  # List all hosted zones
  HOSTED_ZONES=$(aws route53 list-hosted-zones | jq -r .HostedZones[].Id)

  # Loop through each hosted zone and backup its records
  for zone in $HOSTED_ZONES; do
      # Extract the hosted zone ID (the last part of the ARN)
      ZONE_ID=$(echo $zone | cut -d'/' -f3)

      # Get the hosted zone name (used for the backup filename)
      ZONE_NAME=$(aws route53 get-hosted-zone --id $ZONE_ID | jq -r .HostedZone.Name)

      # Backup the record sets for the hosted zone
      aws route53 list-resource-record-sets --hosted-zone-id $ZONE_ID > "$BACKUP_DIR/$ZONE_NAME"'json'
      rv=$?;
      test $rv -ne "0" && exit 1
      echo "Backed up $ZONE_NAME to $BACKUP_DIR/$ZONE_NAME""json"
  done

  do_log "INFO All Route 53 records have been backed up!"
  export exit_code="0"

}
