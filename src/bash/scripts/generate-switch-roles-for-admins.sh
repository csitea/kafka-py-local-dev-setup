 while read -r l; do eval "$l";profile=$(echo $acc|perl -ne 's|-|_|g;print');env=$(echo $acc|cut -f3 -d-);echo -e "\n[$profile]"; echo source_profile = rtr_adm ; echo role_arn = "arn:aws:iam::$id:role/"$env"_iam_role_root_admin"; echo "role_session_name = $profile"_sess; echo region = us-east-1; done < <(aws organizations list-accounts --profile rtr_adm| jq -r '.Accounts[]|select(.Status | startswith("ACTIVE"))|"id="+.Id + "; acc="+.Name')

 #  >> ~/.aws/.$ORG/credentials
