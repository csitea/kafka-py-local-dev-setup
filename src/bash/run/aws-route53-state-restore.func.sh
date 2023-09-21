#!/bin/env bash

do_aws_route53_state_restore() {
  # Define a directory for backups
  BACKUP_DIR="$PRODUCT_DIR/cnf/json/$ORG/aws/root/route53-backups"

  # Check if backup directory exists
  if [ ! -d "$BACKUP_DIR" ]; then
    echo "Backup directory $BACKUP_DIR does not exist. Exiting."
    exit 1
  fi


  do_require_var ORG "${ORG:-}"
  export AWS_SHARED_CREDENTIALS_FILE=~/.aws/.$ORG/credentials

  # Loop through each backup file and restore its records
  for backup_file in $BACKUP_DIR/*.json; do
    # Extract the hosted zone name from the filename
    ZONE_NAME=$(basename $backup_file .json)

    # Get the hosted zone ID based on the zone name
    ZONE_ID=$(aws route53 list-hosted-zones | jq -r --arg ZONE_NAME "$ZONE_NAME." '.HostedZones[] | select(.Name == $ZONE_NAME) | .Id' | cut -d'/' -f3)

    if [ -z "$ZONE_ID" ]; then
      echo "No hosted zone found for $ZONE_NAME. Skipping."
      continue
    fi

    # Read the backup file and extract the resource record sets
    RECORD_SETS=$(jq -c '.ResourceRecordSets[]' $backup_file)

    # Loop through each record set and recreate it
    for record_set in $RECORD_SETS; do
      # Create a temporary JSON file to hold the record set
      echo $record_set > temp_record_set.json

      # Recreate the record set in Route 53
      aws route53 change-resource-record-sets --hosted-zone-id $ZONE_ID --change-batch "{\"Changes\": [{\"Action\": \"UPSERT\", \"ResourceRecordSet\": $(cat temp_record_set.json)}]}"

      # Remove the temporary JSON file
      rm temp_record_set.json
    done

    echo "Restored $ZONE_NAME from $backup_file"
  done

  echo "All Route 53 records have been restored!"
}
