#!/bin/bash
spacelift () {(
set -e

${configuration}

echo "Get certificate" >> /var/log/spacelift/info.log
export SPACELIFT_POOL_PRIVATE_KEY="$(aws ssm get-parameter --region=${region} --name "/${environment}/${component}/spacelift/key" --query 'Parameter.Value' --with-decryption --output text | base64 -w 0)"

echo "Downloading Spacelift launcher" >> /var/log/spacelift/info.log
curl https://downloads.${domain_name}/spacelift-launcher --output /usr/bin/spacelift-launcher 2>>/var/log/spacelift/error.log
echo "Importing public GPG key" >> /var/log/spacelift/info.log
curl https://keys.openpgp.org/vks/v1/by-fingerprint/175FD97AD2358EFE02832978E302FB5AA29D88F7 | gpg --import 2>>/var/log/spacelift/error.log
echo "Downloading Spacelift launcher checksum file and signature" >> /var/log/spacelift/info.log
curl https://downloads.${domain_name}/spacelift-launcher_SHA256SUMS --output spacelift-launcher_SHA256SUMS 2>>/var/log/spacelift/error.log
curl https://downloads.${domain_name}/spacelift-launcher_SHA256SUMS.sig --output spacelift-launcher_SHA256SUMS.sig 2>>/var/log/spacelift/error.log
echo "Verifying checksum signature..." >> /var/log/spacelift/info.log
gpg --verify spacelift-launcher_SHA256SUMS.sig 1>>/var/log/spacelift/info.log 2>>/var/log/spacelift/error.log
retStatus=$?
if [ $retStatus -eq 0 ]; then
    echo "OK\!" >> /var/log/spacelift/info.log
else
    return $retStatus
fi
CHECKSUM=$(cut -f 1 -d ' ' spacelift-launcher_SHA256SUMS)
rm spacelift-launcher_SHA256SUMS spacelift-launcher_SHA256SUMS.sig
LAUNCHER_SHA=$(sha256sum /usr/bin/spacelift-launcher | cut -f 1 -d ' ')
echo "Verifying launcher binary..." >> /var/log/spacelift/info.log
if [[ "$CHECKSUM" == "$LAUNCHER_SHA" ]]; then
  echo "OK\!" >> /var/log/spacelift/info.log
else
  echo "Checksum and launcher binary hash did not match" >> /var/log/spacelift/error.log
  return 1
fi
echo "Making the Spacelift launcher executable" >> /var/log/spacelift/info.log
chmod 755 /usr/bin/spacelift-launcher 2>>/var/log/spacelift/error.log
echo "Retrieving EC2 instance ID" >> /var/log/spacelift/info.log
export SPACELIFT_METADATA_instance_id=$(ec2-metadata --instance-id | cut -d ' ' -f2)
echo "Retrieving EC2 ASG ID" >> /var/log/spacelift/info.log
export SPACELIFT_METADATA_asg_id=$(aws autoscaling --region=${region} describe-auto-scaling-instances --instance-ids $SPACELIFT_METADATA_instance_id | jq -r '.AutoScalingInstances[0].AutoScalingGroupName')
echo "Starting the Spacelift binary" >> /var/log/spacelift/info.log
/usr/bin/spacelift-launcher 1>>/var/log/spacelift/info.log 2>>/var/log/spacelift/error.log
)}
spacelift
