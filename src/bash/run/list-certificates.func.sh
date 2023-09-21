#!/bin/bash

do_list_certificates(){

  do_require_var TLD_DOMAIN "${TLD_DOMAIN:-}"
  do_require_var AWS_PROFILE "${AWS_PROFILE:-}"

  echo running:
  echo aws acm --profile $AWS_PROFILE list-certificates \|jq -r "[.CertificateSummaryList[] | select(.DomainName | contains(\"$TLD_DOMAIN\")) | {domain_name: .DomainName, certificate_arn: .CertificateArn}]"
  aws acm --profile $AWS_PROFILE list-certificates | \
    jq -r "[.CertificateSummaryList[] | select(.DomainName | contains(\"$TLD_DOMAIN\")) | {domain_name: .DomainName, certificate_arn: .CertificateArn}]"


  export exit_code="$?"
}
