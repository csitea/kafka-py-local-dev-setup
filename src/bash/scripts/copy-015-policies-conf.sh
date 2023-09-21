mkdir -p /opt/spe/spe-infra-conf/prp/prp/015-s3-bucket/{log,rcr,idy} ;

while read -r sf; do tf1=$(echo $sf|perl -ne 's|nba|prp|g;print'); tf2=$(echo $tf1|perl -ne 's|stg|tst|g;print');cp -v $sf $tf1; mv -v $tf1 $tf2; done < <(find /opt/spe/spe-infra-conf/prp/stg/015-s3-bucket/ -type f|sort)

git checkout prp/stg/015-s3-bucket/rcr/
git add -f prp

