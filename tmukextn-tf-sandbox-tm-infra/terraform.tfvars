region                        = "eu-west-2"
region_ecr                    = "eu-west-2"
environment                   = "sandbox"
component                     = "tm"
public_domain_name            = "tmukextn.gft-aws.com"
prefix                        = "uk"
kubernetes_cluster_version    = "1.29" # chcek latest
kubernetes_nodegroups_version = "1.29"
kubectl_version               = "1.29.0"       #check latest and update
shared_services_account_id    = "079962189452" # Log-Archive account number
external_secrets_version      = "latest"
//CIS Amazon Linux 2 Benchmark - Level 2 - 2.0.0.29
eks_jumphost_ec2_ami_id = "ami-0a37be92e11bf2660"                                  #Ami Alias: /aws/service/marketplace/prod-dpzmrxn5akqbw/3.0.0.1     # region: (London) eu-west-2  #Product Code: blz4bmy7mfb7is3nvyjoq8718
aws_admin_role_name     = "AWSReservedSSO_AWSAdministratorAccess_2a75b5c7a14fa20b" # TM UK Log Archive Account 
vpc_id                  = "vpc-05b3fe8a216ba7461"                                  # sandbox-tm-vpc in Log archive account

vpc_cidr                 = "172.21.0.0/16"
eks_workers_subnet_cidrs = ["172.21.64.0/18", "172.21.128.0/18", "172.21.192.0/18"]                             #sandbox-tm-private-subnet-eu-west-2a CIDR, sandbox-tm-private-subnet-eu-west-2b CIDR, sandbox-tm-private-subnet-eu-west-2c CIDR
private_subnet_ids       = ["subnet-0ae1d7b6e1c9d2bf1", "subnet-08f70754197f0e95b", "subnet-040ee45cee109a268"] #sandbox-tm-private-subnet-eu-west-2a, sandbox-tm-private-subnet-eu-west-2b, sandbox-tm-private-subnet-eu-west-2c
db_subnet_ids            = ["subnet-0d7179218663a1c23", "subnet-07ac38641b5660d9c", "subnet-081c5eca62a97f0ed"] #sandbox-tm-db-subnet-eu-west-2a, sandbox-tm-db-subnet-eu-west-2b, sandbox-tm-db-subnet-eu-west-2c
public_subnet_ids        = ["subnet-0d1dbf2781f5c7a16", "subnet-00d1a228bf4dee006", "subnet-0d2b91b0ecfce9ceb"] #sandbox-tm-public-subnet-eu-west-2a, sandbox-tm-public-subnet-eu-west-2b, sandbox-tm-public-subnet-eu-west-2c
//msk_subnet_ids           = []

tm_monitoring_enable_ui = true

# MSK settings
enable_broker_logs_export  = false
kafka_broker_instance_type = "kafka.t3.small"
kafka_client_authentication = {
  iam   = true
  scram = true
}

# Aurora settings
aurora_instance_class               = "db.t4g.medium"
aurora_number_of_instances          = 1
aurora_preferred_maintenance_window = "mon:18:00-mon:18:30"
aurora_monitoring_interval          = 30

k8s_logs_alert_medium_treshold_5minutes    = 235
k8s_logs_alert_high_treshold_5minutes      = 470
k8s_logs_alert_superhigh_treshold_5minutes = 940

#ArgoCD settings
github_org_url                 = "https://github.com/gft-blx"
platform_git_ops_repo_name     = "tmukextn-k8s-tm-platform"
applications_git_ops_repo_name = "k8s-tm-microservices"
#github_pat_owner_username      = "gft-blx-integration"
#argocd_github_app_client_id    = "5c00d5a911b577c4f716"
argocd_github_app_id              = "862021"
argocd_github_app_installation_id = "48847201"
argocd_github_oauth_app_client_id = "dd7fc5b64cf98b7c6f78"
argocd_version                    = "latest"
redis_version                     = "latest"


billing_alert_subscriber_emails = [
  "dean.wallis@gft.com",
  "jennifer.nicholas@gft.com",
  "mohammed.asalam@gft.com"
]

L4_tags = {
  "blx:created-by"      = "terraform"
  "blx:owner"           = "all"
  "blx:tag-version"     = "1"
  "blx:repository-name" = "tmukextn-tf-sandbox-tm-infra"
}

#this cron times are used for the eks nodes groups too.
downscale_jumphost_after_working_hours = true
working_hours_start_cron               = "0 6 * * 1-5"  # UTC
working_hours_end_cron                 = "0 10 * * 1-5" # UTC

whitelisted_public_ingress_cidr_ranges = [
  "200.174.251.240/28", // GFT VPN
  "177.159.165.80/28",  // GFT VPN
  "200.174.253.64/26",  // GFT VPN
  "217.243.233.0/25",   // GFT VPN
  "195.243.126.128/26", // GFT VPN
  "185.75.166.208/29",  // GFT VPN
  "185.75.167.32/27",   // GFT VPN
  "195.235.159.0/24",   // GFT VPN
  "42.118.136.74/32",   // KHANH PHAN - FOR TESTING TM
  "89.64.52.20/32",     // JAKUB JANECKI - FOR TESTING TM
  "86.18.112.199/32",   // DEAN WALLIS - FOR TESTING TM
  "82.71.36.158/32",    // JENNIFER NICHOLAS - FOR TESTING TM
  "94.173.182.240/32",  // MOHAMMED ASALAM - FOR TESTING TM
  "86.20.156.62/32",    // RACHEL WHITMORE - FOR TESTING TM
  "79.123.29.227/32",   // JENNIFER GFT OFFC - FOR DEMO TM
]

argocd_ingress_allowed_ip_ranges = [
  "200.174.251.240/28", // GFT VPN
  "177.159.165.80/28",  // GFT VPN
  "200.174.253.64/26",  // GFT VPN
  "217.243.233.0/25",   // GFT VPN
  "195.243.126.128/26", // GFT VPN
  "185.75.166.208/29",  // GFT VPN
  "185.75.167.32/27",   // GFT VPN
  "195.235.159.0/24",   // GFT VPN
  "42.118.136.74/32",   // KHANH PHAN - FOR TESTING TM
  "89.64.52.20/32",     // JAKUB JANECKI - FOR TESTING TM
  "86.18.112.199/32",   // DEAN WALLIS - FOR TESTING TM
  "82.71.36.158/32",    // JENNIFER NICHOLAS - FOR TESTING TM]
  "94.173.182.240/32",  // MOHAMMED ASALAM - FOR TESTING TM
  "86.20.156.62/32",    // RACH WHITMORE - FOR TESTING TM
  "79.123.29.227/32",   // JENNIFER GFT OFFC - FOR DEMO TM
]

tm_monitoring_ingress_allowed_ip_ranges = [
  "200.174.251.240/28", // GFT VPN
  "177.159.165.80/28",  // GFT VPN
  "200.174.253.64/26",  // GFT VPN
  "217.243.233.0/25",   // GFT VPN
  "195.243.126.128/26", // GFT VPN
  "185.75.166.208/29",  // GFT VPN
  "185.75.167.32/27",   // GFT VPN
  "195.235.159.0/24",   // GFT VPN
  "42.118.136.74/32",   // KHANH PHAN - FOR TESTING TM
  "89.64.52.20/32",     // JAKUB JANECKI - FOR TESTING TM
  "86.18.112.199/32",   // DEAN WALLIS - FOR TESTING TM
  "82.71.36.158/32",    // JENNIFER NICHOLAS - FOR TESTING TM
  "94.173.182.240/32",  // MOHAMMED ASALAM - FOR TESTING TM
  "86.20.156.62/32",    // RACH WHITMORE - FOR TESTING TM
  "79.123.29.227/32",   // JENNIFER GFT OFFC - FOR DEMO TM
]

tm_vault_core_ingress_allowed_ip_ranges = [
  "200.174.251.240/28", // GFT VPN
  "177.159.165.80/28",  // GFT VPN
  "200.174.253.64/26",  // GFT VPN
  "217.243.233.0/25",   // GFT VPN
  "195.243.126.128/26", // GFT VPN
  "185.75.166.208/29",  // GFT VPN
  "185.75.167.32/27",   // GFT VPN
  "195.235.159.0/24",   // GFT VPN
  "42.118.136.74/32",   // KHANH PHAN - FOR TESTING TM
  "89.64.52.20/32",     // JAKUB JANECKI - FOR TESTING TM
  "86.18.112.199/32",   // DEAN WALLIS - FOR TESTING TM
  "82.71.36.158/32",    // JENNIFER NICHOLAS - FOR TESTING TM
  "94.173.182.240/32",  // MOHAMMED ASALAM - FOR TESTING TM
  "86.20.156.62/32",    // RACHEL WHITMORE - FOR TESTING TM
  "79.123.29.227/32",   // JENNIFER GFT OFFC - FOR DEMO TM
]

#it must be set 30 mins before than EKS start working hours and 30 mins later than EKS end working hours, pls NOTE that cron format is with 6 terms
aurora_working_hours_start_cron = "30 5 ? * MON-FRI *"  # UTC
aurora_working_hours_end_cron   = "30 10 ? * MON-FRI *" # UTC

approvers_repository_access = {}

db_credentials_secrets = []
