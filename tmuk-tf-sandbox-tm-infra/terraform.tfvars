region                        = "eu-west-2"
region_ecr                    = "eu-west-2"
environment                   = "sandbox"
component                     = "tm"
public_domain_name            = "tmuk.gft-aws.com"
prefix                        = "uk"
kubernetes_cluster_version    = "1.25"
kubernetes_nodegroups_version = "1.25"
kubectl_version               = "1.25.16"
shared_services_account_id    = "051939627954"
external_secrets_version      = "main"
//CIS Amazon Linux 2 Benchmark - Level 2 - 2.0.0.25
eks_jumphost_ec2_ami_id = "ami-0e8b638b5ffe86837"                               #"ami-0d37de1f1f3b705a8"                               # eu-west-2
aws_admin_role_name     = "AWSReservedSSO_AdministratorAccess_a6c05fba94b34a16" # TM UK Sandbox account
vpc_id                  = "vpc-0e0f9cc0c33f913b6"

vpc_cidr                 = "172.21.0.0/16"
eks_workers_subnet_cidrs = ["172.21.64.0/18", "172.21.128.0/18", "172.21.192.0/18"]
private_subnet_ids       = ["subnet-011593ff6a9e61ee4", "subnet-0e6ad8c3a9a03a081", "subnet-0c0330e9bd6d49614"] #["subnet-0a693477cdf3bd3fb", "subnet-09b39d55d3e527541", "subnet-0ad26dc1f6a92a352"]
db_subnet_ids            = ["subnet-096492fc7fd5d3843", "subnet-086e14335b0a44ce3", "subnet-03b467c25711c2840"] #["subnet-04bf677edc6894fa0", "subnet-063f64011bfdea0c7", "subnet-0f8f732bc3592defa"]
public_subnet_ids        = ["subnet-0af6e483ef6aa6060", "subnet-067d94d12da487d3c", "subnet-00842b40ed4d77aaa"] #["subnet-092970d95ab804e3d", "subnet-08013d4a66974c888", "subnet-069f6c9066225b231"]
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
platform_git_ops_repo_name     = "tmuk-k8s-tm-platform"
applications_git_ops_repo_name = "k8s-tm-microservices"
#github_pat_owner_username      = "gft-blx-integration"
#argocd_github_app_client_id    = "5c00d5a911b577c4f716"
argocd_github_app_id              = "700971"
argocd_github_app_installation_id = "45099663"
argocd_github_oauth_app_client_id = "aa077e48f0fece5c2709"
argocd_version                    = "latest"
redis_version                     = "latest"


billing_alert_subscriber_emails = [
  "dean.wallis@gft.com",
  "jennifer.nicholas@gft.com"
]

L4_tags = {
  "blx:created-by"      = "terraform"
  "blx:owner"           = "all"
  "blx:tag-version"     = "1"
  "blx:repository-name" = "tmuk-tf-sandbox-tm-infra"
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
  "82.71.36.158/32",    // JENNIFER NICHOLAS - FOR TESTING TM
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
  "79.123.29.227/32",   // JENNIFER GFT OFFC - FOR DEMO TM
]

#it must be setted 30 mins before than EKS start working hours and 30 mins later than EKS end working hours, pls NOTE that cron format is with 6 terms
aurora_working_hours_start_cron = "30 5 ? * MON-FRI *"  # UTC
aurora_working_hours_end_cron   = "30 10 ? * MON-FRI *" # UTC

approvers_repository_access = {}

db_credentials_secrets = []
