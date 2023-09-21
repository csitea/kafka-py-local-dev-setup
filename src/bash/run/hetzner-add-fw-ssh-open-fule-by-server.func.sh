#!/bin/bash
# this does not work
do_hetzner_add_fw_ssh_open_fule_by_server(){

  do_require_var SERVER_NAME $SERVER_NAME
  do_require_var ORG $ORG
  do_require_var APP $APP
  JSON_ENV_FILE=~/.aws/.$ORG/$ORG-$APP.early-credentials.json
  do_export_json_section_vars "$JSON_ENV_FILE" "."
  # Hetzner API token
  API_TOKEN="$TQA_WWH_ALL_HCLOUD_TOKEN"

  # Get the public IP of the machine running the script using your provided method
  CURRENT_IP=$(curl -s -4 https://ifconfig.me/ip)

  # Get the IP address of the Hetzner server (assuming it's the first server in your list)
  #SERVER_IP=$(curl -s -H "Authorization: Bearer $API_TOKEN" 'https://api.hetzner.cloud/v1/servers' | jq -r '.servers[0].public_net.ipv4.ip')

curl -s -H "Authorization: Bearer $API_TOKEN" 'https://api.hetzner.cloud/v1/servers' | jq -r '.'
  # Fetch the server ID using the server name
  SERVER_ID=$(curl -s -H "Authorization: Bearer $API_TOKEN" 'https://api.hetzner.cloud/v1/servers' | jq -r --arg NAME "$SERVER_NAME" '.servers[] | select(.name == $NAME) | .id')

  if [ -z "$SERVER_ID" ]; then
    echo "Server not found."
    exit
  fi

  # Firewall rule to allow port 22 for both IPs
  RULE='{
      "direction": "in",
      "protocol": "tcp",
      "port": "22",
      "source_ips": ["'"$CURRENT_IP"'", "'"$SERVER_IP"'"],
      "action": "accept",
      "description": "SSH access for "'"$USER"'"@"'"$host_name"'"
  }'

  # Add firewall rule using Hetzner API (Replace YOUR_FIREWALL_ID with the appropriate firewall's ID)
  curl -X POST \
       -H "Authorization: Bearer $API_TOKEN" \
       -H "Content-Type: application/json" \
       -d "$RULE" \
       "https://api.hetzner.cloud/v1/firewalls/YOUR_FIREWALL_ID/rules"
  rv=$?

  do_log "INFO Firewall rule added for IPs: $CURRENT_IP and $SERVER_IP"

  test ${rv:-} -eq "0" && export exit_code="0"

}
