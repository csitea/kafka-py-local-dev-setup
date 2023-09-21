#!/bin/bash

# still the addition of ther users has not been verifield
# cat src/bash/run/create-github-repo.func.sh | head -n 6
# REPO_NAME=hubspot-api-handler DESCRIPTION='a wrapper for hubspot api' ORGANIZATION=csitea PERMISSION='maintain' USER_EMAILS='renato.guimaraes@csitea.net,katariina.jarvenmaki@csitea.net,uliana.burdina@csitea.net,vasil.derilov@csitea.net,hristo.andreev@csitea.net' ./run -a do_create_github_repo
do_create_github_repo(){
	#set -x

	# get & validate
	GIT_USER_EMAIL=$(do_get_env_var "GIT_USER_EMAIL")
	GITHUB_TOKEN=$(do_get_env_var "GITHUB_TOKEN")
	REPO_NAME=$(do_get_env_var "REPO_NAME")
	DESCRIPTION=$(do_get_env_var "DESCRIPTION")
	ORGANIZATION=$(do_get_env_var "ORGANIZATION")
	USER_EMAILS=$(do_get_env_var "USER_EMAILS")
	PERMISSION=$(do_get_env_var "PERMISSION")

	# Create the project
curl_response=$(curl --cookie-jar cookies.txt -s -H "Authorization: token $GITHUB_TOKEN" \
  --data "{\"name\":\"$REPO_NAME\",\"description\":\"$DESCRIPTION\",\"private\":true,\"owner\":\"$ORGANIZATION\"}" \
  "https://api.github.com/orgs/$ORGANIZATION/repos")


	# Get the project URL from the response
	project_url=$(echo "$curl_response" | jq -r '.html_url')


  MAILS=()
	# Add the users with the specified permission level
  IFS=',' read -ra MAILS <<< "$USER_EMAILS"
  if declare -p MAILS &>/dev/null; then
    for email in "${MAILS[@]}"
    do
      curl -s --cookie-jar cookies.txt -H "Authorization: token $GITHUB_TOKEN" \
        -H "Accept: application/vnd.github.v3+json" \
        -X PUT "$project_url/collaborators/$email" --data "{\"permission\":\"$PERMISSION\"}"
    done
  fi

	local rv=$?
	export exit_code="$rv"

}
