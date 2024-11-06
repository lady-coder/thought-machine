#!/bin/bash

usage() {
	echo "Usage: $0 {common name} {environment} {component}"
}

if [ -z $1 ]; then
	usage
	exit 1
fi
env=$(echo "$2" | awk '{ print tolower($0)}')
commonname=$(echo "$1" | awk '{ print tolower($0)}')
component=$(echo "$3" | awk '{ print tolower($0)}')
kmsaliases=$(aws kms list-aliases)

echo "Checking if KMS does not exist already"

arr=$(echo "$kmsaliases" | jq -c -r '.Aliases[].AliasName')
if [[ " ${arr[*]} " =~ "alias/kms-ssm-spacelift" ]]; then
    echo "KMS Key with this alias already exist, exiting the script"
    exit 2
fi

mkdir -p "${env}/${commonname}.new" || ( echo failed to create "${env}/${commonname}.new" ; exit 5 )

echo "Creating the Private Key for Worker Pools"

openssl req -new -newkey rsa:4096 -nodes -keyout "${env}/${commonname}.new/${commonname}.key" -out "${env}/${commonname}.new/${commonname}.csr" -subj "/CN=${commonname}"

if [ "$?" -ne 0 ]; then
	echo There was an error creating the CSR.
	exit 6
fi

echo "Displaying the CSR details for Worker Pool"

openssl req -text -in "${env}/${commonname}.new/${commonname}.csr"

echo "Creating KMS with CMK for Worker Pools's Sensitive Data"

kmskey_worker_pools=$(aws kms create-key --tags TagKey=blx:environment,TagValue=${env} TagKey=blx:cost-center,TagValue=cloud-platform TagKey=blx:data-classification,TagValue=internal TagKey=blx:owner,TagValue=cloud-platform TagKey=blx:staff,TagValue=terraform TagKey=blx:tag-version,TagValue=1 --description "KMS key to encrypt CSR and PRIVATE KEYS for Worker Pools")

echo "KMS KEY ID extraction"

kmskeyid_worker_pools=$(jq -r '.KeyMetadata.KeyId' <<< $kmskey_worker_pools)

echo "Creating Alias for created KMS"

aws kms create-alias --alias-name alias/${env}-spacelift-ssm --target-key-id $kmskeyid_worker_pools

echo "Enabling Key Rotation for created KMS"

aws kms enable-key-rotation --key-id $kmskeyid_worker_pools

############## Pushing Sensitive data - CSRs and Private Key to SSM Parameter

aws ssm put-parameter \
    --name "/$env/$component/spacelift/csr" \
    --value "$(cat ${env}/${commonname}.new/${commonname}.csr)" \
    --type "SecureString" \
    --key-id "$kmskeyid_worker_pools" \
    --tags Key=blx:environment,Value=${env} Key=blx:cost-center,Value=cloud-platform Key=blx:data-classification,Value=internal Key=blx:owner,Value=cloud-platform Key=blx:staff,Value=terraform Key=blx:tag-version,Value=1

aws ssm put-parameter \
    --name "/$env/$component/spacelift/key" \
    --value "$(cat ${env}/${commonname}.new/${commonname}.key)" \
    --type "SecureString" \
    --key-id "$kmskeyid_worker_pools" \
    --tags Key=blx:environment,Value=${env} Key=blx:cost-center,Value=cloud-platform Key=blx:data-classification,Value=internal Key=blx:owner,Value=cloud-platform Key=blx:staff,Value=terraform Key=blx:tag-version,Value=1
