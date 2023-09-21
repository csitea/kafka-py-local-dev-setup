#!/bin/bash

# tst policies
while read -r sf; do tf=$(echo $sf|perl -ne 's|nba|prp|g;print'); mkdir -p `dirname $tf`; cp -v $sf $tf ; perl -pi -e 's|nba|prp|g' $tf ; done < <(find `pwd` -name cicd_backend_policy.json | grep -i tst|grep -i nba)
while read -r sf; do tf=$(echo $sf|perl -ne 's|nba|prp|g;print'); mkdir -p `dirname $tf`; cp -v $sf $tf ; perl -pi -e 's|nba|prp|g' $tf ; done < <(find `pwd` -name cicd_ui_policy.json | grep -i tst|grep -i nba)
while read -r sf; do tf=$(echo $sf|perl -ne 's|nba|prp|g;print'); mkdir -p `dirname $tf`; cp -v $sf $tf ; perl -pi -e 's|nba|prp|g' $tf ; done < <(find `pwd` -name infra_admins_policy.json | grep -i tst|grep -i nba)
while read -r sf; do tf=$(echo $sf|perl -ne 's|nba|prp|g;print'); mkdir -p `dirname $tf`; cp -v $sf $tf ; perl -pi -e 's|nba|prp|g' $tf ; done < <(find `pwd` -name developer_policy.json | grep -i tst|grep -i nba)

while read -r sf; do tf=$(echo $sf|perl -ne 's|nba|prp|g;print'); mkdir -p `dirname $tf`; cp -v $sf $tf ; perl -pi -e 's|nba|prp|g' $tf ; done < <(find `pwd` -name developer_policy.json | grep -i tst|grep -i nba)
while read -r sf; do tf=$(echo $sf|perl -ne 's|nba|prp|g;print'); mkdir -p `dirname $tf`; cp -v $sf $tf ; perl -pi -e 's|nba|prp|g' $tf ; done < <(find `pwd` -name devops_policy.json | grep -i tst|grep -i nba)
while read -r sf; do tf=$(echo $sf|perl -ne 's|nba|prp|g;print'); mkdir -p `dirname $tf`; cp -v $sf $tf ; perl -pi -e 's|nba|prp|g' $tf ; done < <(find `pwd` -name fe_developer_policy.json | grep -i tst|grep -i nba)
while read -r sf; do tf=$(echo $sf|perl -ne 's|nba|prp|g;print'); mkdir -p `dirname $tf`; cp -v $sf $tf ; perl -pi -e 's|nba|prp|g' $tf ; done < <(find `pwd` -name be_developer_policy.json | grep -i tst|grep -i nba)

# stg policies
while read -r sf; do tf=$(echo $sf|perl -ne 's|nba|prp|g;print'); mkdir -p `dirname $tf`; cp -v $sf $tf ; perl -pi -e 's|nba|prp|g' $tf ; done < <(find `pwd` -name cicd_backend_policy.json | grep -i stg|grep -i nba)
while read -r sf; do tf=$(echo $sf|perl -ne 's|nba|prp|g;print'); mkdir -p `dirname $tf`; cp -v $sf $tf ; perl -pi -e 's|nba|prp|g' $tf ; done < <(find `pwd` -name cicd_ui_policy.json | grep -i stg|grep -i nba)
while read -r sf; do tf=$(echo $sf|perl -ne 's|nba|prp|g;print'); mkdir -p `dirname $tf`; cp -v $sf $tf ; perl -pi -e 's|nba|prp|g' $tf ; done < <(find `pwd` -name infra_admins_policy.json | grep -i stg|grep -i nba)
while read -r sf; do tf=$(echo $sf|perl -ne 's|nba|prp|g;print'); mkdir -p `dirname $tf`; cp -v $sf $tf ; perl -pi -e 's|nba|prp|g' $tf ; done < <(find `pwd` -name developer_policy.json | grep -i stg|grep -i nba)

while read -r sf; do tf=$(echo $sf|perl -ne 's|nba|prp|g;print'); mkdir -p `dirname $tf`; cp -v $sf $tf ; perl -pi -e 's|nba|prp|g' $tf ; done < <(find `pwd` -name developer_policy.json | grep -i stg|grep -i nba)
while read -r sf; do tf=$(echo $sf|perl -ne 's|nba|prp|g;print'); mkdir -p `dirname $tf`; cp -v $sf $tf ; perl -pi -e 's|nba|prp|g' $tf ; done < <(find `pwd` -name devops_policy.json | grep -i stg|grep -i nba)
while read -r sf; do tf=$(echo $sf|perl -ne 's|nba|prp|g;print'); mkdir -p `dirname $tf`; cp -v $sf $tf ; perl -pi -e 's|nba|prp|g' $tf ; done < <(find `pwd` -name fe_developer_policy.json | grep -i stg|grep -i nba)
while read -r sf; do tf=$(echo $sf|perl -ne 's|nba|prp|g;print'); mkdir -p `dirname $tf`; cp -v $sf $tf ; perl -pi -e 's|nba|prp|g' $tf ; done < <(find `pwd` -name be_developer_policy.json | grep -i stg|grep -i nba)

# prd policies
while read -r sf; do tf=$(echo $sf|perl -ne 's|nba|prp|g;print'); mkdir -p `dirname $tf`; cp -v $sf $tf ; perl -pi -e 's|nba|prp|g' $tf ; done < <(find `pwd` -name cicd_backend_policy.json | grep -i prd|grep -i nba)
while read -r sf; do tf=$(echo $sf|perl -ne 's|nba|prp|g;print'); mkdir -p `dirname $tf`; cp -v $sf $tf ; perl -pi -e 's|nba|prp|g' $tf ; done < <(find `pwd` -name cicd_ui_policy.json | grep -i prd|grep -i nba)
while read -r sf; do tf=$(echo $sf|perl -ne 's|nba|prp|g;print'); mkdir -p `dirname $tf`; cp -v $sf $tf ; perl -pi -e 's|nba|prp|g' $tf ; done < <(find `pwd` -name infra_admins_policy.json | grep -i prd|grep -i nba)
while read -r sf; do tf=$(echo $sf|perl -ne 's|nba|prp|g;print'); mkdir -p `dirname $tf`; cp -v $sf $tf ; perl -pi -e 's|nba|prp|g' $tf ; done < <(find `pwd` -name developer_policy.json | grep -i prd|grep -i nba)

while read -r sf; do tf=$(echo $sf|perl -ne 's|nba|prp|g;print'); mkdir -p `dirname $tf`; cp -v $sf $tf ; perl -pi -e 's|nba|prp|g' $tf ; done < <(find `pwd` -name developer_policy.json | grep -i prd|grep -i nba)
while read -r sf; do tf=$(echo $sf|perl -ne 's|nba|prp|g;print'); mkdir -p `dirname $tf`; cp -v $sf $tf ; perl -pi -e 's|nba|prp|g' $tf ; done < <(find `pwd` -name devops_policy.json | grep -i stg|grep -i nba)
while read -r sf; do tf=$(echo $sf|perl -ne 's|nba|prp|g;print'); mkdir -p `dirname $tf`; cp -v $sf $tf ; perl -pi -e 's|nba|prp|g' $tf ; done < <(find `pwd` -name fe_developer_policy.json | grep -i stg|grep -i nba)
while read -r sf; do tf=$(echo $sf|perl -ne 's|nba|prp|g;print'); mkdir -p `dirname $tf`; cp -v $sf $tf ; perl -pi -e 's|nba|prp|g' $tf ; done < <(find `pwd` -name be_developer_policy.json | grep -i stg|grep -i nba)
