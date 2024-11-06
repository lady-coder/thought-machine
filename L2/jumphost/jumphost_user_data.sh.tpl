#!/bin/bash
# update yum
sudo yum update -y

# install common packages
sudo yum install -y jq unzip git wget bash-completion

# install awscliv2
sudo yum remove awscli -y
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install

# install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/v${kubectl_version}/bin/linux/amd64/kubectl
chmod a+rx ./kubectl
mv ./kubectl /usr/local/bin/kubectl

# install psql client
sudo tee /etc/yum.repos.d/pgdg.repo<<EOF
[pgdg13]
name=PostgreSQL 14 for RHEL/CentOS 7 - x86_64
baseurl=https://download.postgresql.org/pub/repos/yum/14/redhat/rhel-7-x86_64
enabled=1
gpgcheck=0
EOF
sudo yum install postgresql14 -y

# install kafka client
JUMPHOST_BINARIES_DIR="/opt"
echo "Downloading kafka client"
wget -q https://archive.apache.org/dist/kafka/3.3.1/kafka_2.12-3.3.1.tgz
echo "Kafka client downloaded"
tar xf kafka_2.12-3.3.1.tgz && mv kafka_2.12-3.3.1 $JUMPHOST_BINARIES_DIR/kafka-client && chmod -R 775 $JUMPHOST_BINARIES_DIR/kafka-client/
sudo amazon-linux-extras install java-openjdk11

# install aws msk iam auth
echo "Downloading AWS MSK IAM auth client"
wget -q https://repo1.maven.org/maven2/software/amazon/msk/aws-msk-iam-auth/1.1.5/aws-msk-iam-auth-1.1.5-all.jar
echo "MSK IAM auth client downloaded"
mv aws-msk-iam-auth-1.1.5-all.jar $JUMPHOST_BINARIES_DIR/kafka-client/libs
sudo tee $JUMPHOST_BINARIES_DIR/kafka-client/clientapps.properties<<EOF
security.protocol=SASL_SSL
sasl.mechanism=AWS_MSK_IAM
sasl.jaas.config = software.amazon.msk.auth.iam.IAMLoginModule required;
sasl.client.callback.handler.class=software.amazon.msk.auth.iam.IAMClientCallbackHandler
EOF

# install argocd cli
echo "Downloading argocd client"
wget -q https://github.com/argoproj/argo-cd/releases/download/v2.5.1/argocd-linux-amd64
echo "Argocd client downloaded"
sudo mv ./argocd-linux-amd64 /usr/local/bin/argocd
sudo chmod a+rx /usr/local/bin/argocd

curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 > get_helm.sh
chmod 700 get_helm.sh
source ./get_helm.sh
chmod a+rx /usr/local/bin//helm

# configure the cluster context
aws eks update-kubeconfig --name ${cluster_name} --region ${region}
mv /root/.kube $JUMPHOST_BINARIES_DIR
chmod -R 775 $JUMPHOST_BINARIES_DIR/.kube
echo "export KUBECONFIG=$JUMPHOST_BINARIES_DIR/.kube/config" > /etc/profile.d/kubectl.sh
chmod 644 /etc/profile.d/kubectl.sh
sudo echo 'source <(kubectl completion bash)' >> /home/ssm-user/.bashrc

# set comfortable aliases to .bashrc
sudo echo -e "\nalias k='kubectl'" >> /home/ssm-user/.bashrc

# set user home as the default workspace for bash
sudo echo -e "cd" >> /home/ssm-user/.bashrc
