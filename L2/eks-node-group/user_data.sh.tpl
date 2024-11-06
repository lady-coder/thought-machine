MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="//"

--//
Content-Type: text/x-shellscript; charset="us-ascii"
#!/bin/bash
set -ex

/etc/eks/bootstrap.sh $CLUSTER_NAME --kubelet-extra-args 'eks.amazonaws.com/capacityType=$CAPACITY_TYPE,eks.amazonaws.com/nodegroup=$NODEGROUP,Name=$NODEGROUP --max-pods=$MAX_POD' --b64-cluster-ca $B64_CLUSTER_CA --apiserver-endpoint $API_SERVER_URL --dns-cluster-ip $K8S_CLUSTER_DNS_IP --use-max-pods false
--//--
