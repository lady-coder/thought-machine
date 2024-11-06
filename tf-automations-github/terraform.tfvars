billing_email = "purchasing.poland@gft.com"
name          = "BankLiteX"
owner         = "gft-blx"

#############################################################################
# DEFINE YOUR REPOSITORY AND TEAMS THAT SHARE MAINTAINING PERMISSION HERE
#############################################################################
repositories = {
  airflow-jobs = {
    description        = "Repository for Airflow jobs",
    contributors_teams = ["data_engineers_team"]
  }
  apollo-server = {
    description        = "Repository for application apollo-server",
    contributors_teams = ["mobile_apollo_server_team"]
  }
  aurora-automations-apps = {
    description       = "Repository for Aurora automations",
    maintainers_teams = ["cloud_platform_devops_team", "data_infra_team"]
  }
  crr-calc-service = {
    description        = "Repository for application crr-calc-service",
    template_name      = "microservice-template",
    contributors_teams = ["deposit_team", "customer_team"]
  }
  customer-cbs-service = {
    description        = "Repository for application customer-cbs-service",
    template_name      = "microservice-template",
    contributors_teams = ["deposit_team", "customer_team"]
  }
  customer-iam-gateway = {
    description        = "Repository for application customer-iam-gateway",
    template_name      = "microservice-template",
    contributors_teams = ["deposit_team", "customer_team"]
  }
  customer-iam-service = {
    description        = "Repository for application customer-iam-service",
    template_name      = "microservice-template",
    contributors_teams = ["deposit_team", "customer_team"]
  }
  customer-identity-service = {
    description        = "Repository for application customer-identity-service",
    template_name      = "microservice-template",
    contributors_teams = ["deposit_team", "customer_team"]
  }
  customer-phone-verification-service = {
    description        = "Repository for application customer-phone-verification-service",
    template_name      = "microservice-template",
    contributors_teams = ["deposit_team", "customer_team"]
  }
  customer-service = {
    description        = "Repository for application customer-service",
    template_name      = "microservice-template",
    contributors_teams = ["deposit_team", "customer_team"]
  }
  customer-transaction-service = {
    description        = "Repository for application customer-transaction-service",
    template_name      = "microservice-template",
    contributors_teams = ["deposit_team", "customer_team"]
  }
  data-lake-tests = {
    description        = "Repository for Data Lake tests",
    contributors_teams = ["data_engineers_team"]
  }
  dcr-service = {
    description        = "Repository for application dcr-service",
    template_name      = "microservice-template",
    contributors_teams = ["deposit_team", "customer_team"]
  }
  deposit-account-service = {
    description        = "Repository for application deposit-account-service",
    template_name      = "microservice-template",
    contributors_teams = ["deposit_team", "customer_team"]
  }
  deposit-balance-service = {
    description        = "Repository for application deposit-balance-service",
    template_name      = "microservice-template",
    contributors_teams = ["deposit_team", "customer_team"]
  }
  deposit-portfolio-service = {
    description        = "Repository for application deposit-portfolio-service",
    template_name      = "microservice-template",
    contributors_teams = ["deposit_team", "customer_team"]
  }
  deposit-transfer-service = {
    description        = "Repository for application deposit-transfer-service",
    template_name      = "microservice-template",
    contributors_teams = ["deposit_team", "customer_team"]
  }
  direct-debit-service = {
    description        = "Repository for application direct-debit-service",
    template_name      = "microservice-template",
    contributors_teams = ["payments_team"]
  }
  documentation = {
    description        = "Documentation, diagrams and Getting started",
    contributors_teams = ["deposit_team", "customer_team", "cloud_platform_devops_team"]
  }
  emr-container-image = {
    description        = "Repository for EMR container image",
    contributors_teams = ["data_engineers_team"]
  }
  esb-mock-service = {
    description        = "Repository for Esb Adapter Mock",
    template_name      = "microservice-template",
    contributors_teams = ["payments_team"]
  }
  helm-template = {
    description        = "Repository for Helm Template",
    contributors_teams = ["cloud_platform_devops_team", "deposit_team", "customer_team", "mobile_apollo_server_team"]
  }
  instant-payment-service = {
    description        = "Repository for application instant-payment-service",
    template_name      = "microservice-template",
    contributors_teams = ["payments_team"]
  }
  java-microservice-gradle-plugins = {
    description        = "Repository for Java Gradle microservice plugins",
    contributors_teams = ["cloud_platform_devops_team", "deposit_team", "customer_team", "mobile_apollo_server_team"]
  }
  java-microservice-libraries = {
    description        = "Repository for Java microservice libraries",
    contributors_teams = ["cloud_platform_devops_team", "deposit_team", "customer_team", "mobile_apollo_server_team"]
  }
  java-microservice-contracts = {
    description        = "Repository for Java microservice apis/schemas (contracts)",
    template_name      = "microservice-template",
    contributors_teams = ["cloud_platform_devops_team", "deposit_team", "customer_team", "mobile_apollo_server_team"]
  }
  k8s-apps-microservices = {
    description        = "Repository for K8S Apps microservices",
    contributors_teams = ["cloud_platform_devops_team", "deposit_team", "customer_team", "mobile_apollo_server_team", "data_infra_team"]
  }
  k8s-tm-microservices = {
    description        = "Repository for TM Apps microservices",
    contributors_teams = ["cloud_platform_devops_team", "data_infra_team"]
  }
  k8s-apps-platform = {
    description        = "Repository for K8S Apps platform applications",
    contributors_teams = ["cloud_platform_devops_team", "data_infra_team"]
  }
  k8s-data-platform = {
    description        = "Repository for K8S Data platform applications",
    contributors_teams = ["cloud_platform_devops_team", "data_infra_team"]
  }
  k8s-hcvault-platform = {
    description        = "Repository for HCVault Platform",
    contributors_teams = ["cloud_platform_devops_team"]
  }
  k8s-shared-services-platform = {
    description        = "Repository for K8S Shared Services platform applications",
    contributors_teams = ["cloud_platform_devops_team", "digitaleye_platform_team"]
  }
  k8s-tm-platform = {
    description        = "Repository for K8S Thought Machine platform applications",
    contributors_teams = ["cloud_platform_devops_team", "data_infra_team"]
  }
  kafka-automations-apps = {
    description        = "Repository for Kafka automations",
    contributors_teams = ["cloud_platform_devops_team", "data_infra_team"]
  }
  kafka-connectors = {
    description        = "Repository for Kafka connectors",
    contributors_teams = ["data_engineers_team"]
  }
  kafka-connect-smt = {
    description        = "Single Message Transformation for Kafka Connect",
    contributors_teams = ["data_engineers_team"]
  }
  microservice-template = {
    description        = "Repository for microservice-template project",
    contributors_teams = ["template_team", "cloud_platform_devops_team"]
  }
  mirroring-poc = {
    description        = "PoC of mirroring solution",
    contributors_teams = ["cloud_platform_devops_team"]
  }
  onboarding-service = {
    description        = "Repository for application onboarding-service",
    template_name      = "microservice-template",
    contributors_teams = ["deposit_team", "customer_team"]
  }
  kafka-s3-ingestion-service = {
    description        = "Repository for application kafka-s3-ingestion-service",
    template_name      = "microservice-template",
    contributors_teams = ["deposit_team", "customer_team", "data_engineers_team"]
  }
  payments-adapter-mock = {
    description        = "Repository for application payments-adapter-mock",
    template_name      = "microservice-template",
    contributors_teams = ["payments_team"]
  }
  pyspark-jobs = {
    description        = "Repository for PySpark jobs",
    contributors_teams = ["data_engineers_team"]
  }
  spark-jobs = {
    description        = "Repository for Spark jobs",
    contributors_teams = ["data_engineers_team"]
  }
  tm-configuration-layer-blx-products = {
    description        = "Repository for CI/CD delivery pipeline for smart contract",
    contributors_teams = ["data_engineers_team"]
  }
  statement-service = {
    description        = "Repository for application statement-service",
    template_name      = "microservice-template",
    contributors_teams = ["deposit_team", "customer_team"]
  }
  tf-automations-github = {
    description        = "Automations for GitHub resources",
    contributors_teams = ["cloud_platform_architecture_team", "cloud_platform_devops_team", "digitaleye_be_team", "digitaleye_fe_team", "digitaleye_platform_team"]
  }
  tf-modules = {
    description        = "Terraform modules",
    contributors_teams = ["cloud_platform_architecture_team", "cloud_platform_devops_team", "data_infra_team", "digitaleye_platform_team"]
  }
  tf-sandbox-apps-infra = {
    description        = "L4 module for sandbox infrastructure",
    contributors_teams = ["cloud_platform_devops_team", "data_infra_team"]
  }
  tf-sandbox-apps-networking = {
    description        = "L4 module for sandbox networking",
    contributors_teams = ["cloud_platform_devops_team"]
  }
  tf-sandbox-apps-observability = {
    description        = "L4 module for sandbox apps observability",
    contributors_teams = ["cloud_platform_devops_team"]
  }
  tf-sandbox-data-infra = {
    description        = "L4 module for sandbox data infrastructure",
    contributors_teams = ["cloud_platform_devops_team", "data_infra_team"]
  }
  tf-sandbox-tm-infra = {
    description        = "L4 module for thoughtmachine sandbox infrastructure",
    contributors_teams = ["cloud_platform_devops_team", "data_infra_team"]
  }
  tf-sandbox-tm-networking = {
    description        = "L4 module for thoughtmachine sandbox networking",
    contributors_teams = ["cloud_platform_devops_team"]
  }
  tf-shared-services-infra = {
    description        = "L4 module for shared services infrastructure",
    contributors_teams = ["cloud_platform_devops_team", "data_infra_team", "digitaleye_platform_team"]
  }
  tf-shared-services-networking = {
    description        = "L4 module for shared services networking",
    contributors_teams = ["cloud_platform_devops_team", "digitaleye_platform_team"]
  }
  tf-shared-services-observability = {
    description        = "L4 module for shared services observability",
    contributors_teams = ["cloud_platform_devops_team"]
  }
  tf-spacelift-prerequisites = {
    description        = "Prerequisites for setting up Spacelift",
    contributors_teams = ["cloud_platform_devops_team", "data_infra_team", "digitaleye_platform_team"]
  }
  tf-spacelift-stacks = {
    description        = "Spacelift configuration",
    contributors_teams = ["cloud_platform_architecture_team", "cloud_platform_devops_team", "data_infra_team", "digitaleye_platform_team"]
  }
  thought-machine-components = {
    description        = "Repository for Thought Machine components",
    contributors_teams = ["cloud_platform_devops_team", "deposit_team", "customer_team", "mobile_apollo_server_team"]
  }
  tm-automation-tools = {
    description        = "Repository for TM automation tools",
    contributors_teams = ["cloud_platform_devops_team"]
  }
  tokenizer-service = {
    description        = "Service for tokenizer",
    contributors_teams = ["data_engineers_team"]
  }
  tokenizer-config-service = {
    description        = "Service for tokenizer configuration",
    contributors_teams = ["data_engineers_team"]
  }
  transaction-limit-service = {
    description        = "Repository for application transaction-limit-service",
    template_name      = "microservice-template",
    contributors_teams = ["deposit_team", "customer_team"]
  }
  transaction-service = {
    description        = "Repository for application transaction-service",
    template_name      = "microservice-template",
    contributors_teams = ["deposit_team", "customer_team"]
  }
  twilio-otp-gateway = {
    description        = "Repository for application twilio-otp-gateway",
    template_name      = "microservice-template",
    contributors_teams = ["deposit_team", "customer_team"]
  }
  workflow-service = {
    description        = "Repository for application workflow-service",
    template_name      = "microservice-template",
    contributors_teams = ["deposit_team", "customer_team"]
  }
  # DigitalEye Repositories
  nbo-admin-node = {
    additional_protected_branch = ["release"],
    description                 = "Digital Eye Admin Node API",
    contributors_teams          = ["digitaleye_be_team", "digitaleye_fe_team", "digitaleye_platform_team"],
    triage_teams                = ["digitaleye_team"],
    readonly_teams              = ["gft_engineers"]
  }
  nbo-admin-node-ui = {
    additional_protected_branch = ["release"],
    description                 = "Digital Eye Admin Node UI",
    contributors_teams          = ["digitaleye_be_team", "digitaleye_fe_team", "digitaleye_platform_team"],
    triage_teams                = ["digitaleye_team"],
    readonly_teams              = ["gft_engineers"]
  }
  nbo-go-iden3-core = {
    additional_protected_branch = ["release"],
    description                 = "Digital Eye Go Iden3 Core",
    contributors_teams          = ["digitaleye_be_team", "digitaleye_fe_team", "digitaleye_platform_team"],
    triage_teams                = ["digitaleye_team"],
    readonly_teams              = ["gft_engineers"]
  }
  nbo-hl-besu = {
    additional_protected_branch = ["release"],
    description                 = "Digital Eye Hyperledger Besu",
    contributors_teams          = ["digitaleye_be_team", "digitaleye_fe_team", "digitaleye_platform_team"],
    triage_teams                = ["digitaleye_team"],
    readonly_teams              = ["gft_engineers"]
  }
  nbo-ipfs = {
    additional_protected_branch = ["release"],
    description                 = "Digital Eye IPFS",
    contributors_teams          = ["digitaleye_be_team", "digitaleye_fe_team", "digitaleye_platform_team"],
    triage_teams                = ["digitaleye_team"],
    readonly_teams              = ["gft_engineers"]
  }
  nbo-ipfs-cluster-manager = {
    additional_protected_branch = ["release"],
    description                 = "Digital Eye IPFS Cluster Manager Proxy",
    contributors_teams          = ["digitaleye_be_team", "digitaleye_fe_team", "digitaleye_platform_team"],
    triage_teams                = ["digitaleye_team"],
    readonly_teams              = ["gft_engineers"]
  }
  nbo-issuer-node = {
    additional_protected_branch = ["release"],
    description                 = "Digital Eye Issuer Node API",
    contributors_teams          = ["digitaleye_be_team", "digitaleye_fe_team", "digitaleye_platform_team"],
    triage_teams                = ["digitaleye_team"],
    readonly_teams              = ["gft_engineers"]
  }
  nbo-translation-node = {
    additional_protected_branch = ["release"],
    description                 = "Digital Eye Translation Node",
    contributors_teams          = ["digitaleye_be_team", "digitaleye_fe_team", "digitaleye_platform_team"],
    triage_teams                = ["digitaleye_team"],
    readonly_teams              = ["gft_engineers"]
  }
  nbo-issuer-node-ui = {
    additional_protected_branch = ["release"],
    description                 = "Digital Eye Issuer Node UI",
    contributors_teams          = ["digitaleye_be_team", "digitaleye_fe_team", "digitaleye_platform_team"],
    triage_teams                = ["digitaleye_team"],
    readonly_teams              = ["gft_engineers"]
  }
  nbo-js-iden3-core = {
    additional_protected_branch = ["release"],
    description                 = "Digital Eye TypeScript Iden3 core",
    contributors_teams          = ["digitaleye_be_team", "digitaleye_fe_team", "digitaleye_platform_team"],
    triage_teams                = ["digitaleye_team"],
    readonly_teams              = ["gft_engineers"]
  }
  nbo-js-sdk = {
    additional_protected_branch = ["release"],
    description                 = "Digital Eye TypeScript SDK",
    contributors_teams          = ["digitaleye_be_team", "digitaleye_fe_team", "digitaleye_platform_team"],
    triage_teams                = ["digitaleye_team"],
    readonly_teams              = ["gft_engineers"]
  }
  nbo-k8s-apps-platform = {
    additional_protected_branch = ["release"],
    description                 = "Digital Eye K8s Platform Baseline Applications",
    contributors_teams          = ["digitaleye_be_team", "digitaleye_fe_team", "digitaleye_platform_team"],
    triage_teams                = ["digitaleye_team"],
    readonly_teams              = ["gft_engineers"]
  }
  nbo-pdf-service = {
    additional_protected_branch = ["release"],
    description                 = "Digital Eye PDF Generation Service",
    contributors_teams          = ["digitaleye_be_team", "digitaleye_fe_team", "digitaleye_platform_team"],
    triage_teams                = ["digitaleye_team"],
    readonly_teams              = ["gft_engineers"]
  }
  nbo-smart-contracts = {
    additional_protected_branch = ["release"],
    description                 = "Digital Eye Smart Contracts",
    contributors_teams          = ["digitaleye_be_team", "digitaleye_fe_team", "digitaleye_platform_team"],
    triage_teams                = ["digitaleye_team"],
    readonly_teams              = ["gft_engineers"]
  }
  nbo-trusted-registry-contract = {
    description        = "Digital Eye Trusted Registry Smart Contracts",
    contributors_teams = ["digitaleye_be_team", "digitaleye_fe_team", "digitaleye_platform_team"],
    triage_teams       = ["digitaleye_team"],
    readonly_teams     = ["gft_engineers"]
  }
  nbo-tf-environment = {
    description        = "Terraform Infrastructure-as-Code codebase for all DigitalEye Infrastructure Environments",
    gitignore_template = "Terraform",
    contributors_teams = ["digitaleye_be_team", "digitaleye_fe_team", "digitaleye_platform_team"],
    triage_teams       = ["digitaleye_team"],
    readonly_teams     = ["gft_engineers"]
  }
  nbo-vault-plugin-secrets-iden3 = {
    additional_protected_branch = ["release"],
    description                 = "Digital Eye Vault Iden3 Plugin for Iden3 protocol secrets handling",
    contributors_teams          = ["digitaleye_be_team", "digitaleye_platform_team"],
    triage_teams                = ["digitaleye_team"],
    readonly_teams              = ["gft_engineers"]
  }
  nbo-verifier-node = {
    additional_protected_branch = ["release"],
    description                 = "Digital Eye Verifier Node APIs",
    contributors_teams          = ["digitaleye_be_team", "digitaleye_fe_team", "digitaleye_platform_team"],
    triage_teams                = ["digitaleye_team"],
    readonly_teams              = ["gft_engineers"]
  }
  nbo-verifier-node-ui = {
    additional_protected_branch = ["release"],
    description                 = "Digital Eye Verifier Node UI",
    contributors_teams          = ["digitaleye_be_team", "digitaleye_fe_team", "digitaleye_platform_team"],
    triage_teams                = ["digitaleye_team"],
    readonly_teams              = ["gft_engineers"]
  }
  nbo-wallet-extension = {
    additional_protected_branch = ["release"],
    description                 = "Digital Eye Wallet Extension",
    contributors_teams          = ["digitaleye_be_team", "digitaleye_fe_team", "digitaleye_platform_team"],
    triage_teams                = ["digitaleye_team"],
    readonly_teams              = ["gft_engineers"]
  }
  nbo-wallet-mobile = {
    additional_protected_branch = ["release"],
    description                 = "Digital Eye Wallet Mobile Application",
    maintainers_teams           = ["digitaleye_app_build_team"]
    contributors_teams          = ["digitaleye_be_team", "digitaleye_fe_team", "digitaleye_platform_team"],
    triage_teams                = ["digitaleye_team"],
    readonly_teams              = ["gft_engineers"]
  }
  # UK Thought Machine
  tmuk-k8s-tm-platform = {
    description        = "UK team repository for K8S Thought Machine platform applications",
    contributors_teams = ["tmuk_team", "cloud_platform_devops_team", "data_infra_team"],
    readonly_teams     = ["gft_engineers"]
  }

  tmukextn-k8s-tm-platform = {
    description        = "UK EXTENSION team repository for K8S Thought Machine platform applications ",
    contributors_teams = ["tmuk_team", "cloud_platform_devops_team", "data_infra_team"],
    readonly_teams     = ["gft_engineers"]
  }

  tmuk-tf-sandbox-tm-infra = {
    description        = "UK team L4 module for thoughtmachine sandbox infrastructure",
    contributors_teams = ["tmuk_team", "cloud_platform_devops_team"],
    readonly_teams     = ["gft_engineers"]
  }
  tmuk-tf-sandbox-tm-networking = {
    description        = "UK team L4 module for thoughtmachine sandbox networking",
    contributors_teams = ["tmuk_team", "cloud_platform_devops_team"],
    readonly_teams     = ["gft_engineers"]
  }

  tmukextn-tf-sandbox-tm-infra = {
    description        = "UK EXTENSION team L4 module for thoughtmachine sandbox infrastructure",
    contributors_teams = ["tmuk_team", "cloud_platform_devops_team"],
    readonly_teams     = ["gft_engineers"]
  }
  tmukextn-tf-sandbox-tm-networking = {
    description        = "UK EXTENSION team L4 module for thoughtmachine sandbox networking",
    contributors_teams = ["tmuk_team", "cloud_platform_devops_team"],
    readonly_teams     = ["gft_engineers"]
  }

  tmuk-tf-infra-maintenance = {
    description        = "UK team L4, modules to allow for maintainance of AWS infra",
    contributors_teams = ["tmuk_team", "cloud_platform_devops_team"],
    readonly_teams     = ["gft_engineers"]
  }
  tmuk-tf-spacelift-prerequisites = {
    description        = "UK TM Prerequisites for setting up Spacelift",
    contributors_teams = ["tmuk_team", "cloud_platform_devops_team"],
    readonly_teams     = ["gft_engineers"]
  }
  tmuk-automation-tools = {
    description        = "UK TM Repository for TMUK automation tools",
    contributors_teams = ["tmuk_team", "cloud_platform_devops_team"],
    readonly_teams     = ["gft_engineers"]
  }

  tmukextn-tf-spacelift-prerequisites = {
    description        = "UK EXTENSION TM Prerequisites for setting up Spacelift ",
    contributors_teams = ["tmuk_team", "cloud_platform_devops_team"],
    readonly_teams     = ["gft_engineers"]
  }
  tmukextn-automation-tools = {
    description        = "UK EXTENSION TM Repository for TMUK automation tools",
    contributors_teams = ["tmuk_team", "cloud_platform_devops_team"],
    readonly_teams     = ["gft_engineers"]
  }
  # MBH
  loan-account-service = {
    description        = "Repository for Loan Account Service",
    template_name      = "microservice-template",
    contributors_teams = ["loan_team"]
  }
  loan-transaction-service = {
    description        = "Repository for Loan Transaction Service",
    template_name      = "microservice-template",
    contributors_teams = ["loan_team"]
  }
  loan-product-service = {
    description        = "Repository for Loan Product Service",
    template_name      = "microservice-template",
    contributors_teams = ["loan_team"]
  }
  vault-customer-service = {
    description        = "Repository for Vault Customer Service",
    template_name      = "microservice-template",
    contributors_teams = ["loan_origination_team"]
  }
  loan_application_service = {
    description        = "Repository for Loan Application Service",
    template_name      = "microservice-template",
    contributors_teams = ["loan_origination_team"]
  }
  ubf-product-catalogue = {
    description        = "Repository for UBF product catalogue",
    template_name      = "microservice-template",
    contributors_teams = ["ubf_team"]
  }
}

###################################################
# DEFINE YOUR TEAM AND ASSIGN MEMBERS HERE
###################################################
teams = {
  # All GFT Engineers
  gft_engineers = {
    description = "All GFT Engineers"
    maintainers = [
      "gft-blx-integration", # Github BLX Automation Account (PIC: jaroslaw.szczepankiewicz@gft.com)
      "jjaneckiGFT",         # jakub.janecki@gft.com
      "jszczepankiewicz",    # jaroslaw.szczepankiewicz@gft.com
      "tylern91",            # tyler.nguyen@gft.com
    ],
    members = [
      "AndriNazarovGft",        # andrii.nazarov@gft.com
      "adampaprosgft",          # adam.papros@gft.com
      "adampgi",                # ampg@gft.com
      "bartosz-milczarek-gft",  # bartosz.milczarek@gft.com
      "bartoszstasikowski-gft", # bartosz.stasikowski@gft.com
      "BartGFT",                # bartosz.maciag@gft.com
      "boassoh",                # hernan-sergio.boasso@gft.com
      "czerniga-gft",           # patrycjusz.czerniga@gft.com
      "damianwolnygft",         # damian.wolny@gft.com
      "DariuszBudynek",         # dariusz.budynek@gft.com
      "deanbrucewallis",        # dean.wallis@gft.com
      "dgrabow",                # daniel.grabowski@gft.com
      "diendoan-gft",           # dien.doan@gft.com
      "e-amgy",                 # adam.goralczyk@gft.com
      "e-mzwk",                 # mateusz.wieczorek@gft.com
      "e-prgi",                 # piotr.gorajski@gft.com
      "e-uzpc",                 # lukasz.przytocki@gft.com
      "gftwally",               # waldemar.trawnicki@gft.com
      "g-maak",                 # michal.marcinkowski@gft.com
      "hania-gft",              # hanna.wyszynska@gft.com
      "JackGajjar-GFT",         # jack.gajjar@gft.com
      "jennifer-gft",           # jennifer.nicholas@gft.com
      "KamilBemowskiGFT",       # kamil.bemowski@gft.com
      "kamilklosowski-gft",     # kamil.klosowski@gft.com
      "karolblanik-gft",        # karol.blanik@gft.com
      "kiennguyen-gft",         # kien.dinhnguyen@gft.com
      "lamnguyengft",           # lam.hongnguyen@gft.com
      "lgardiasz",              # lukasz.gardiasz@gft.com
      "long-hoang-gft",         # long.hoang@gft.com
      "lukasz-perski-gft",      # lukasz.perski@gft.com
      "kdoi2",                  # kdoi@gft.com
      "M-As17",                 # mohammed.asalam@gft.com
      "maciej-malinowski-gft",  # mjmi@gft.com
      "maciejbajorgft",         # maciej.bajor@gft.com
      "magda-pelikant-gft",     # magda.pelikant@gft.com
      "marcinbil-gft",          # marcin.bil@gft.com
      "marcingft",              # marcin.formela@gft.com
      "mariusz-grela-dragon",   # mariusz.grela@gft.com
      "michal-gft",             # michal.przybylski@gft.com
      "michaldziedzicgft",      # michal.dziedzic@gft.com
      "minhluong-gft",          # minh.luong@gft.com
      "mkonczak",               # marcin.konczak@gft.com
      "mnpk-gft",               # marcin.peczek@gft.com
      "moradifaeze",            # faeze.moradi@gft.com
      "mtse-gft",               # mykyta.sikriier@gft.com
      "mwieczorkiewiczgft",     # mariusz.wieczorkiewicz@gft.com
      "mzbygft",                # mateusz.blaszczyk@gft.com
      "oliviertruquet",         # olivier.truquet@gft.com
      "pawel-waclaw-gft",       # pawel.waclaw@gft.com
      "PaulinaGFT",             # paulina.leszczynska@gft.com
      "petro-gft",              # petro.gnatyuk@gft.com
      "piotrstarobrat",         # piotr.starobrat@gft.com
      "prdsgft",                # prds@gft.com
      "pwlk-gft",               # przemyslaw.lesniewski@gft.com
      "rafalciepielgft",        # rafal.ciepiel@gft.com
      "rafalnowakowskigft",     # rafal.nowakowski@gft.com
      "sergmikita",             # siarhei.mikita@gft.com
      "tamtrangft",             # tam.thanhtran@gft.com
      "tkreciewskigft",         # tomasz.kreciewski@gft.com
      "tmiecznikowski",         # tomasz.miecznikowski@gft.com
      "tuanle-gft",             # tnsb@gft.com
    ]
  }
  # Cloud Platform Teams
  cloud_platform_architecture_team = {
    description = "Cloud Platform Architecture Team",
    maintainers = [
      "jjaneckiGFT",      # jakub.janecki@gft.com
      "jszczepankiewicz", # jaroslaw.szczepankiewicz@gft.com
      "tylern91",         # tyler.nguyen@gft.com
    ],
    members = [
      "adampaprosgft",   # adam.papros@gft.com
      "boassoh",         # hernan-sergio.boasso@gft.com=
      "czerniga-gft",    # patrycjusz.czerniga@gft.com
      "DariuszBudynek",  # dariusz.budynek@gft.com
      "damianwolnygft",  # damian.wolny@gft.com
      "g-maak",          # michal.marcinkowski@gft.com
      "moradifaeze",     # faeze.moradi@gft.com
      "prdsgft",         # prds@gft.com
      "rafalciepielgft", # rafal.ciepiel@gft.com
    ]
  }
  cloud_platform_devops_team = {
    description = "Cloud Platform DevOps Team",
    maintainers = [
      "jjaneckiGFT",      # jakub.janecki@gft.com
      "jszczepankiewicz", # jaroslaw.szczepankiewicz@gft.com
      "tylern91",         # tyler.nguyen@gft.com
    ],
    members = [
      "adampaprosgft",         # adam.papros@gft.com
      "BartGFT",               # bartosz.maciag@gft.com
      "bartosz-milczarek-gft", # bartosz.milczarek@gft.com
      "boassoh",               # hernan-sergio.boasso@gft.com
      "czerniga-gft",          # patrycjusz.czerniga@gft.com
      "damianwolnygft",        # damian.wolny@gft.com
      "DariuszBudynek",        # dariusz.budynek@gft.com
      "deanbrucewallis",       # dean.wallis@gft.com
      "diendoan-gft",          # dien.doan@gft.com
      "e-mzwk",                # mateusz.wieczorek@gft.com
      "g-maak",                # michal.marcinkowski@gft.com
      "jennifer-gft",          # jennifer.nicholas@gft.com
      "kiennguyen-gft",        # kien.dinhnguyen@gft.coms
      "M-As17",                # mohammed.asalam@gft.com
      "moradifaeze",           # faeze.moradi@gft.com
      "piotrstarobrat",        # piotr.starobrat@gft.com
      "pawelbolonekgft",       # pawel.bolonek@gft.com
      "pwlk-gft",              # przemyslaw.lesniewski@gft.com
      "rafalciepielgft",       # rafal.ciepiel@gft.com
    ]
  }
  template_team = {
    description = "Template Team",
    maintainers = [
      "jjaneckiGFT",      # jakub.janecki@gft.com
      "jszczepankiewicz", # jaroslaw.szczepankiewicz@gft.com
      "tylern91",         # tyler.nguyen@gft.com
    ],
    members = [
      "bartosz-milczarek-gft",    # bartosz.milczarek@gft.com
      "bartoszstasikowski-gft",   # bartosz.stasikowski@gft.com
      "dgrabow",                  # daniel.grabowski@gft.com
      "e-amgy",                   # adam.goralczyk@gft.com
      "filipmijalskigft",         # filip.mijalski@gft.com
      "gft-bartlomiej-zielinski", # bartlomiej.zielinski@gft.com
      "lgardiasz",                # lukasz.gardiasz@gft.com
      "mndigft",                  # marcin.dabrowski@gft.com
      "prdsgft",                  # prds@gft.com
      "sergmikita",               # siarhei.mikita@gft.com
      "szewi",                    # kamil.szewczyk@gft.com
    ]
  }

  # BLX Deposit Teams
  deposit_team = {
    description = "Deposit Team",
    maintainers = [
      "piotrstarobrat", # piotr.starobrat@gft.com
    ],
    members = [
      "adampaprosgft",            # adam.papros@gft.com
      "bartosz-milczarek-gft",    # bartosz.milczarek@gft.com
      "bartoszstasikowski-gft",   # bartosz.stasikowski@gft.com
      "BartGFT",                  # bartosz.maciag@gft.com
      "czerniga-gft",             # patrycjusz.czerniga@gft.com
      "damianwolnygft",           # damian.wolny@gft.com
      "DariuszBudynek",           # dariusz.budynek@gft.com
      "e-amgy",                   # adam.goralczyk@gft.com
      "e-mzwk",                   # mateusz.wieczorek@gft.com
      "g-maak",                   # michal.marcinkowski@gft.com
      "e-prgi",                   # piotr.gorajski@gft.com
      "filipmijalskigft",         # filip.mijalski@gft.com
      "gft-bartlomiej-zielinski", # bartlomiej.zielinski@gft.com
      "kdoi2",                    # kdoi@gft.com
      "lgardiasz",                # lukasz.gardiasz@gft.com
      "lukasz-perski-gft",        # lukasz.perski@gft.com
      "marcinbil-gft",            # marcin.bil@gft.com
      "michaldziedzicgft",        # michal.dziedzic@gft.com
      "moradifaeze",              # faeze.moradi@gft.com
      "mzbygft",                  # mateusz.blaszczyk@gft.com
      "PaulinaGFT",               # paulina.leszczynska@gft.com
      "prdsgft",                  # prds@gft.com
      "rafalciepielgft",          # rafal.ciepiel@gft.com
      "rafalnowakowskigft",       # rafal.nowakowski@gft.com
      "sergmikita",               # siarhei.mikita@gft.com
      "tmiecznikowski",           # tomasz.miecznikowski@gft.com
    ]
  }
  deposit_approvers = {
    description = "Deposit Approvers",
    maintainers = [
      "piotrstarobrat", # piotr.starobrat@gft.com
    ],
    members = [
      "adampaprosgft",   # adam.papros@gft.com
      "czerniga-gft",    # patrycjusz.czerniga@gft.com
      "DariuszBudynek",  # dariusz.budynek@gft.com
      "g-maak",          # michal.marcinkowski@gft.com
      "moradifaeze",     # faeze.moradi@gft.com
      "prdsgft",         # prds@gft.com
      "rafalciepielgft", # rafal.ciepiel@gft.com
    ]
  }
  # BLX Mobile Teams
  mobile_apollo_server_team = {
    description = "Mobile Team",
    maintainers = [],
    members = [
      "adampaprosgft",   # adam.papros@gft.com
      "czerniga-gft",    # patrycjusz.czerniga@gft.com
      "g-maak",          # michal.marcinkowski@gft.com
      "DariuszBudynek",  # dariusz.budynek@gft.com
      "moradifaeze",     # faeze.moradi@gft.com
      "prdsgft",         # prds@gft.com
      "rafalciepielgft", # rafal.ciepiel@gft.com
    ]
  }
  mobile_apollo_server_approvers = {
    description = "Mobile Approvers",
    maintainers = [],
    members = [
      "adampaprosgft",   # adam.papros@gft.com
      "czerniga-gft",    # patrycjusz.czerniga@gft.com
      "g-maak",          # michal.marcinkowski@gft.com
      "DariuszBudynek",  # dariusz.budynek@gft.com
      "moradifaeze",     # faeze.moradi@gft.com
      "prdsgft",         # prds@gft.com
      "rafalciepielgft", # rafal.ciepiel@gft.com
    ]
  }
  # BLX Customer Teams
  customer_team = {
    description = "Customer Team",
    maintainers = [
      "piotrstarobrat", # piotr.starobrat@gft.com
    ],
    members = [
      "adampaprosgft",            # adam.papros@gft.com
      "bartosz-milczarek-gft",    # bartosz.milczarek@gft.com
      "bartoszstasikowski-gft",   # bartosz.stasikowski@gft.com
      "BartGFT",                  # bartosz.maciag@gft.com
      "czerniga-gft",             # patrycjusz.czerniga@gft.com
      "damianwolnygft",           # damian.wolny@gft.com
      "e-amgy",                   # adam.goralczyk@gft.com
      "e-mzwk",                   # mateusz.wieczorek@gft.com
      "e-prgi",                   # piotr.gorajski@gft.com
      "filipmijalskigft",         # filip.mijalski@gft.com
      "gft-bartlomiej-zielinski", # bartlomiej.zielinski@gft.com
      "g-maak",                   # michal.marcinkowski@gft.com
      "DariuszBudynek",           # dariusz.budynek@gft.com
      "kdoi2",                    # kdoi@gft.com
      "lgardiasz",                # lukasz.gardiasz@gft.com
      "lukasz-perski-gft",        # lukasz.perski@gft.com
      "marcinbil-gft",            # marcin.bil@gft.com
      "michaldziedzicgft",        # michal.dziedzic@gft.com
      "moradifaeze",              # faeze.moradi@gft.com
      "mzbygft",                  # mateusz.blaszczyk@gft.com
      "PaulinaGFT",               # paulina.leszczynska@gft.com
      "prdsgft",                  # prds@gft.com
      "rafalciepielgft",          # rafal.ciepiel@gft.com
      "rafalnowakowskigft",       # rafal.nowakowski@gft.com
      "sergmikita",               # siarhei.mikita@gft.com
      "tmiecznikowski",           # tomasz.miecznikowski@gft.com
    ]
  }
  customer_approvers = {
    description = "Customer Approvers",
    maintainers = [
      "piotrstarobrat", # piotr.starobrat@gft.com
    ],
    members = [
      "adampaprosgft",   # adam.papros@gft.com
      "czerniga-gft",    # patrycjusz.czerniga@gft.com
      "g-maak",          # michal.marcinkowski@gft.com
      "DariuszBudynek",  # dariusz.budynek@gft.com
      "moradifaeze",     # faeze.moradi@gft.com
      "prdsgft",         # prds@gft.com
      "rafalciepielgft", # rafal.ciepiel@gft.com
    ]
  }
  # BLX Data Teams
  data_infra_team = {
    description = "Data Infrastructure Team",
    maintainers = [
      "pwlk-gft", # przemyslaw.lesniewski@gft.com
    ],
    members = [
      "adampaprosgft",        # adam.papros@gft.com
      "czerniga-gft",         # patrycjusz.czerniga@gft.com
      "g-maak",               # michal.marcinkowski@gft.com
      "DariuszBudynek",       # dariusz.budynek@gft.com
      "e-prgi",               # piotr.gorajski@gft.com
      "maciejbajorgft",       # maciej.bajor@gft.com
      "magda-pelikant-gft",   # magda.pelikant@gft.com
      "mariusz-grela-dragon", # mariusz.grela@gft.com
      "mwieczorkiewiczgft",   # mariusz.wieczorkiewicz@gft.com
      "moradifaeze",          # faeze.moradi@gft.com
      "prdsgft",              # prds@gft.com
      "rafalciepielgft",      # rafal.ciepiel@gft.com
    ]
  }
  data_engineers_team = {
    description = "Data Team",
    maintainers = [
      "pwlk-gft", # przemyslaw.lesniewski@gft.com
    ],
    members = [
      "adampaprosgft",        # adam.papros@gft.com
      "czerniga-gft",         # patrycjusz.czerniga@gft.com
      "g-maak",               # michal.marcinkowski@gft.com
      "DariuszBudynek",       # dariusz.budynek@gft.com
      "e-prgi",               # piotr.gorajski@gft.com
      "maciejbajorgft",       # maciej.bajor@gft.com
      "magda-pelikant-gft",   # magda.pelikant@gft.com
      "mariusz-grela-dragon", # mariusz.grela@gft.com
      "moradifaeze",          # faeze.moradi@gft.com
      "mwieczorkiewiczgft",   # mariusz.wieczorkiewicz@gft.com
      "prdsgft",              # prds@gft.com
      "rafalciepielgft",      # rafal.ciepiel@gft.com
      "tkreciewskigft",       # tomasz.kreciewski@gft.com
    ]
  }
  # DigitalEye Teams
  digitaleye_team = {
    description = "Aramco DigitalEye Team",
    maintainers = [
      "gftwally",         # waldemar.trawnicki@gft.com
      "KamilBemowskiGFT", # kamil.bemowski@gft.com
      "michal-gft",       # michal.przybylski@gft.com
      "tylern91",         # tyler.nguyen@gft.com
    ],
    members = [
      "AndriNazarovGft",   # andrii.nazarov@gft.com
      "dgrabow",           # daniel.grabowski@gft.com
      "diendoan-gft",      # dien.doan@gft.com
      "ducquoc-gft",       # duc.minhquoc@gft.com
      "hania-gft",         # hanna.wyszynska@gft.com
      "kiennguyen-gft",    # kien.dinhnguyen@gft.com
      "lamnguyengft",      # lam.hongnguyen@gft.com
      "long-hoang-gft",    # long.hoang@gft.com
      "marcingft",         # marcin.formela@gft.com
      "minhluong-gft",     # minh.luong@gft.com
      "mkonczak",          # marcin.konczak@gft.com
      "mndigft",           # marcin.dabrowski@gft.com
      "oliviertruquet",    # olivier.truquet@gft.com
      "pawelbolonekgft",   # pawel.bolonek@gft.com
      "pawel-waclaw-gft",  # pawel.waclaw@gft.com
      "petro-gft",         # petro.gnatyuk@gft.com
      "szewi",             # kamil.szewczyk@gft.com
      "tamtrangft",        # tam.thanhtran@gft.com
      "tetianabrzezinska", # tetiana.brzezinska@gft.com
      "tuanle-gft",        # tnsb@gft.com
    ]
  }
  digitaleye_app_build_team = {
    description = "Digital Eye Application Build Team",
    maintainers = [
      "hania-gft",        # hanna.wyszynska@gft.com
      "KamilBemowskiGFT", # kamil.bemowski@gft.com
      "michal-gft",       # michal.przybylski@gft.com
    ],
    members = [
      "AndriNazarovGft",   # andrii.nazarov@gft.com
      "minhluong-gft",     # minh.luong@gft.com
      "pawel-waclaw-gft",  # pawel.waclaw@gft.com
      "tetianabrzezinska", # tetiana.brzezinska@gft.com
    ]
  }
  digitaleye_be_team = {
    description = "Digital Eye Backend Team",
    maintainers = [
      "gftwally",         # waldemar.trawnicki@gft.com
      "KamilBemowskiGFT", # kamil.bemowski@gft.com
    ],
    members = [
      "ducquoc-gft",      # duc.minhquoc@gft.com
      "long-hoang-gft",   # long.hoang@gft.com
      "marcingft",        # marcin.formela@gft.com
      "michal-gft",       # michal.przybylski@gft.com
      "mkonczak",         # marcin.konczak@gft.com
      "pawel-waclaw-gft", # pawel.waclaw@gft.com
      "petro-gft",        # petro.gnatyuk@gft.com
      "tuanle-gft",       # tnsb@gft.com
    ]
  }
  digitaleye_fe_team = {
    description = "Digital Eye Frontend Team",
    maintainers = [
      "gftwally",   # waldemar.trawnicki@gft.com
      "michal-gft", # michal.przybylski@gft.com
    ],
    members = [
      "AndriNazarovGft",   # andrii.nazarov@gft.com
      "lamnguyengft",      # lam.hongnguyen@gft.com
      "minhluong-gft",     # minh.luong@gft.com
      "pawel-waclaw-gft",  # pawel.waclaw@gft.com
      "tamtrangft",        # tam.thanhtran@gft.com
      "tetianabrzezinska", # tetiana.brzezinska@gft.com
    ]
  }
  digitaleye_platform_team = {
    description = "Digital Eye Team",
    maintainers = [
      "tylern91", # tyler.nguyen@gft.com
    ],
    members = [
      "dgrabow",         # daniel.grabowski@gft.com
      "diendoan-gft",    # dien.doan@gft.com
      "kiennguyen-gft",  # kien.dinhnguyen@gft.com
      "mndigft",         # marcin.dabrowski@gft.com
      "pawelbolonekgft", # pawel.bolonek@gft.com
      "szewi",           # kamil.szewczyk@gft.com
    ]
  }
  # UK Thought Machine Teams
  tmuk_team = {
    description = "TM UK GFT Team",
    maintainers = [
      "deanbrucewallis", # dean.wallis@gft.com
      "JackGajjar-GFT",  # jack.gajjar@gft.com
      "jennifer-gft",    # jennifer.nicholas@gft.com
      "M-As17",          # mohammed.asalam@gft.com
    ],
    members = []
  }
  loan_team = {
    description = "Loan Team",
    maintainers = [
      "piotrstarobrat",        # piotr.starobrat@gft.com
      "adampaprosgft",         # adam.papros@gft.com
      "bartosz-milczarek-gft", # bartosz.milczarek@gft.com
    ],
    members = [
      "e-uzpc",                # lukasz.przytocki@gft.com
      "maciej-malinowski-gft", # mjmi@gft.com
      "marcinbil-gft",         # marcin.bil@gft.com
      "lgardiasz",             # lukasz.gardiasz@gft.com
      "PaulinaGFT",            # paulina.leszczynska@gft.com
    ]
  }
  payments_team = {
    description = "Payments Team",
    maintainers = [
      "adampgi",                  # ampg@gft.com
      "BartGFT",                  # bartosz.maciag@gft.com
      "e-amgy",                   # adam.goralczyk@gft.com
      "gft-bartlomiej-zielinski", # bartlomiej.zielinski@gft.com
      "maciejbajorgft",           # maciej.bajor@gft.com
      "mzbygft",                  # mateusz.blaszczyk@gft.com
      "tmiecznikowski",           # tomasz.miecznikowski@gft.com
    ],
    members = []
  }
  loan_origination_team = {
    description = "Loan Origination Team",
    maintainers = [
      "damianwolnygft",     # damian.wolny@gft.com
      "filipmijalskigft",   # filip.mijalski@gft.com
      "michaldziedzicgft",  # michal.dziedzic@gft.com
      "rafalnowakowskigft", # rafal.nowakowski@gft.com
    ],
    members = []
  }
  # BLX UBF Team
  ubf_team = {
    description = "UBF Team",
    maintainers = [
      "kamilklosowski-gft", # kamil.klosowski@gft.com
    ],
    members = [
      "karolblanik-gft", # karol.blanik@gft.com
    ]
  }
}

###################################################
# DEFINE WORKFLOWS CONFIGURATION HERE
###################################################

allowed_workflows_actions = [
  # BankLiteX
  "gft-blx/*",
  "deepakputhraya/action-pr-title@*",
  "unfor19/install-aws-cli-action@*",
  "endbug/add-and-commit@*",
  "reviewdog/action-flake8@*",
  "tsuyoshicho/action-mypy@*",
  "MishaKav/pytest-coverage-comment@*",
  "hashicorp/setup-terraform@*",
  "terraform-linters/setup-tflint@*",
  "bridgecrewio/checkov-action@*",
  "mnmandahalf/check-ecr-image-exists@*",
  "dev-hanz-ops/install-gh-cli-action@*",
  "dorny/paths-filter@*",

  # DigitalEye
  "golangci/golangci-lint-action@*",
  "isbang/compose-action@*"
]
