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
  documentation = {
    description        = "Documentation, diagrams and Getting started",
    contributors_teams = ["deposit_team", "customer_team", "cloud_platform_devops_team"]
  }
  emr-container-image = {
    description        = "Repository for EMR container image",
    contributors_teams = ["data_engineers_team"]
  }
  helm-template = {
    description        = "Repository for Helm Template",
    contributors_teams = ["cloud_platform_devops_team", "deposit_team", "customer_team", "mobile_apollo_server_team"]
  }
  java-microservice-gradle-plugins = {
    description        = "Repository for Java Gradle microservice plugins",
    contributors_teams = ["cloud_platform_devops_team", "deposit_team", "customer_team", "mobile_apollo_server_team"]
  }
  java-microservice-libraries = {
    description        = "Repository for Java microservice libraries",
    contributors_teams = ["cloud_platform_devops_team", "deposit_team", "customer_team", "mobile_apollo_server_team"]
  }
  k8s-apps-microservices = {
    description        = "Repository for K8S Apps microservices",
    contributors_teams = ["cloud_platform_devops_team", "deposit_team", "customer_team", "mobile_apollo_server_team", "data_infra_team"]
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
    contributors_teams = ["cloud_platform_devops_team", "nbo_platform_team"]
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
    contributors_teams = ["cloud_platform_devops_team"]
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
  spark-jobs = {
    description        = "Repository for PySpark jobs",
    contributors_teams = ["data_engineers_team"]
  }
  statement-service = {
    description        = "Repository for application statement-service",
    template_name      = "microservice-template",
    contributors_teams = ["deposit_team", "customer_team"]
  }
  tf-automations-github = {
    description        = "Automations for GitHub resources",
    contributors_teams = ["cloud_platform_architecture_team", "cloud_platform_devops_team", "nbo_be_team", "nbo_fe_team", "nbo_platform_team"]
  }
  tf-modules = {
    description        = "Terraform modules",
    contributors_teams = ["cloud_platform_architecture_team", "cloud_platform_devops_team", "data_infra_team", "nbo_platform_team"]
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
    contributors_teams = ["cloud_platform_devops_team", "data_infra_team", "nbo_platform_team"]
  }
  tf-shared-services-networking = {
    description        = "L4 module for shared services networking",
    contributors_teams = ["cloud_platform_devops_team", "nbo_platform_team"]
  }
  tf-shared-services-observability = {
    description        = "L4 module for shared services observability",
    contributors_teams = ["cloud_platform_devops_team"]
  }
  tf-spacelift-prerequisites = {
    description        = "Prerequisites for setting up Spacelift",
    contributors_teams = ["cloud_platform_devops_team", "data_infra_team", "nbo_platform_team"]
  }
  tf-spacelift-stacks = {
    description        = "Spacelift configuration",
    contributors_teams = ["cloud_platform_architecture_team", "cloud_platform_devops_team", "data_infra_team", "nbo_platform_team"]
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
    description        = "NBO admin node",
    contributors_teams = ["nbo_be_team", "nbo_fe_team", "nbo_platform_team"],
    triage_teams       = ["nbo_team"],
    readonly_teams     = ["gft_engineers"]
  }
  nbo-admin-node-ui = {
    description        = "NBO admin node ui",
    contributors_teams = ["nbo_be_team", "nbo_fe_team", "nbo_platform_team"],
    triage_teams       = ["nbo_team"],
    readonly_teams     = ["gft_engineers"]
  }
  nbo-go-iden3-core = {
    description        = "NBO go iden3 core",
    contributors_teams = ["nbo_be_team", "nbo_fe_team", "nbo_platform_team"],
    triage_teams       = ["nbo_team"],
    readonly_teams     = ["gft_engineers"]
  }
  nbo-hl-besu = {
    description        = "NBO Hyperledger Besu",
    contributors_teams = ["nbo_be_team", "nbo_fe_team", "nbo_platform_team"],
    triage_teams       = ["nbo_team"],
    readonly_teams     = ["gft_engineers"]
  }
  nbo-ipfs = {
    description        = "NBO IPFS",
    contributors_teams = ["nbo_be_team", "nbo_fe_team", "nbo_platform_team"],
    triage_teams       = ["nbo_team"],
    readonly_teams     = ["gft_engineers"]
  }
  nbo-issuer-node = {
    description        = "NBO issuer node",
    contributors_teams = ["nbo_be_team", "nbo_fe_team", "nbo_platform_team"],
    triage_teams       = ["nbo_team"],
    readonly_teams     = ["gft_engineers"]
  }
  nbo-issuer-node-ui = {
    description        = "NBO Issuer Node UI",
    contributors_teams = ["nbo_be_team", "nbo_fe_team", "nbo_platform_team"],
    triage_teams       = ["nbo_team"],
    readonly_teams     = ["gft_engineers"]
  }
  nbo-js-iden3-core = {
    description        = "NBO js iden3 core",
    contributors_teams = ["nbo_be_team", "nbo_fe_team", "nbo_platform_team"],
    triage_teams       = ["nbo_team"],
    readonly_teams     = ["gft_engineers"]
  }
  nbo-js-sdk = {
    description        = "NBO js sdk",
    contributors_teams = ["nbo_be_team", "nbo_fe_team", "nbo_platform_team"],
    triage_teams       = ["nbo_team"],
    readonly_teams     = ["gft_engineers"]
  }
  nbo-k8s-apps-platform = {
    description        = "Repository for NBO K8s Apps platform applications",
    contributors_teams = ["nbo_be_team", "nbo_fe_team", "nbo_platform_team"],
    triage_teams       = ["nbo_team"],
    readonly_teams     = ["gft_engineers"]
  }
  nbo-pdf-service = {
    description        = "NBO pdf generation service",
    contributors_teams = ["nbo_be_team", "nbo_fe_team", "nbo_platform_team"],
    triage_teams       = ["nbo_team"],
    readonly_teams     = ["gft_engineers"]
  }
  nbo-sample-go = {
    description        = "NBO sampple go",
    contributors_teams = ["nbo_be_team", "nbo_fe_team", "nbo_platform_team"],
    triage_teams       = ["nbo_team"],
    readonly_teams     = ["gft_engineers"]
  }
  nbo-smart-contracts = {
    description        = "NBO Smart Contracts",
    contributors_teams = ["nbo_be_team", "nbo_fe_team", "nbo_platform_team"],
    triage_teams       = ["nbo_team"],
    readonly_teams     = ["gft_engineers"]
  }
  nbo-tf-environment = {
    description        = "Terraform Infrastructure-as-Code codebase for all DigitalEye infrastructure environments",
    gitignore_template = "Terraform",
    contributors_teams = ["nbo_be_team", "nbo_fe_team", "nbo_platform_team"],
    triage_teams       = ["nbo_team"],
    readonly_teams     = ["gft_engineers"]
  }
  nbo-verifier-node = {
    description        = "NBO verifier node",
    contributors_teams = ["nbo_be_team", "nbo_fe_team", "nbo_platform_team"],
    triage_teams       = ["nbo_team"],
    readonly_teams     = ["gft_engineers"]
  }
  nbo-verifier-node-ui = {
    description        = "NBO verifier node UI",
    contributors_teams = ["nbo_be_team", "nbo_fe_team", "nbo_platform_team"],
    triage_teams       = ["nbo_team"],
    readonly_teams     = ["gft_engineers"]
  }
  nbo-wallet-extension = {
    description        = "NBO wallet extension",
    contributors_teams = ["nbo_be_team", "nbo_fe_team", "nbo_platform_team"],
    triage_teams       = ["nbo_team"],
    readonly_teams     = ["gft_engineers"]
  }
  # UK Thought Machine
  tmuk-k8s-tm-platform = {
    description        = "UK team repository for K8S Thought Machine platform applications",
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
      "anisadel",
      "boassoh",             # hernan-sergio.boasso@gft.com
      "deanbrucewallis",     # dean.wallis@gft.com
      "diendoan-gft",        # dien.doan@gft.com
      "GFTedmondsiu",        # ???
      "gftwally",            # waldemar.trawnicki@gft.com
      "hania-gft",           # ???
      "jennifer-gft",        # jennifer.nicholas@gft.com
      "KamilBemowskiGFT",    # kamil.bemowski@gft.com
      "lamnguyengft",        # lam.hongnguyen@gft.com
      "long-hoang-gft",      # long.hoang@gft.com
      "longvu-gft",          # long.thanhvu@gft.com
      "marcingft",           # marcin.formela@gft.com
      "michal-gft",          # michal.przybylski@gft.com
      "michalsmialkowski",   # michal.smialkowski@gft.com
      "MichalWaledziakGFT",  # michal.waledziak@gft.com
      "minhluong-gft",       # minh.luong@gft.com
      "mkonczak",            # marcin.konczak@gft.com
      "mtse-gft",            # mykyta.sikriier@gft.com
      "pawel-waclaw-gft",    # pawel.waclaw@gft.com
      "petro-gft",           # petro.gnatyuk@gft.com
      "piotrstarobrat",      # piotr.starobrat@gft.com=
      "pwlk-gft",            # przemyslaw.lesniewski@gft.com
      "Rekha-Thimman-Gowda", # rekha.gowda@gft.com
      "SunkyGee",            #sunkanmi.gbajobi@gft.com
      "tamtrangft",          # tam.thanhtran@gft.com
      "tuanle-gft",          # tnsb@gft.com
      "vudo-gft",            # vu.anhdo@gft.com
      "WojciechSpotonGFT",   # wojciech.spoton@gft.com
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
      "boassoh", # hernan-sergio.boasso@gft.com=
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
      "boassoh",             # hernan-sergio.boasso@gft.com
      "deanbrucewallis",     # dean.wallis@gft.com
      "diendoan-gft",        # dien.doan@gft.com
      "jennifer-gft",        #jennifer.nicholas@gft.com
      "longvu-gft",          # long.thanhvu@gft.com
      "michalsmialkowski",   # michal.smialkowski@gft.com
      "Rekha-Thimman-Gowda", # rekha.gowda@gft.com
      "SunkyGee",            # sunkanmi.gbajobi@gft.com
      "vudo-gft",            # vu.anhdo@gft.com
    ]
  }
  # BLX Deposit Teams
  deposit_team = {
    description = "Deposit Team",
    maintainers = [
      "piotrstarobrat",    # piotr.starobrat@gft.com
      "WojciechSpotonGFT", # wojciech.spoton@gft.com
    ],
    members = []
  }
  deposit_approvers = {
    description = "Deposit Approvers",
    maintainers = [
      "piotrstarobrat",    # piotr.starobrat@gft.com
      "WojciechSpotonGFT", # wojciech.spoton@gft.com
    ],
    members = []
  }
  # BLX Mobile Teams
  mobile_apollo_server_team = {
    description = "Mobile Team",
    maintainers = [
      "MichalWaledziakGFT", # michal.waledziak@gft.com
    ],
    members = []
  }
  mobile_apollo_server_approvers = {
    description = "Mobile Approvers",
    maintainers = [
      "MichalWaledziakGFT", # michal.waledziak@gft.com
    ],
    members = []
  }
  # BLX Customer Teams
  customer_team = {
    description = "Customer Team",
    maintainers = [
      "piotrstarobrat",    # piotr.starobrat@gft.com
      "WojciechSpotonGFT", # wojciech.spoton@gft.com
    ],
    members = []
  }
  customer_approvers = {
    description = "Customer Approvers",
    maintainers = [
      "piotrstarobrat",    # piotr.starobrat@gft.com
      "WojciechSpotonGFT", # wojciech.spoton@gft.com
    ],
    members = []
  }
  # BLX Data Teams
  data_infra_team = {
    description = "Data Infrastructure Team",
    maintainers = [
      "pwlk-gft", # przemyslaw.lesniewski@gft.com
    ],
    members = []
  }
  data_engineers_team = {
    description = "Data Team",
    maintainers = [
      "pwlk-gft", # przemyslaw.lesniewski@gft.com
    ],
    members = []
  }
  # DigitalEye Teams
  nbo_team = {
    description = "NBO Team",
    maintainers = [
      "gftwally",         # waldemar.trawnicki@gft.com
      "KamilBemowskiGFT", # kamil.bemowski@gft.com
      "michal-gft",       # michal.przybylski@gft.com
      "tylern91",         # tyler.nguyen@gft.com
    ],
    members = [
      "diendoan-gft",     # dien.doan@gft.com
      "ducquoc-gft",      # duc.minhquoc@gft.com
      "lamnguyengft",     # lam.hongnguyen@gft.com
      "long-hoang-gft",   # long.hoang@gft.com
      "longvu-gft",       # long.thanhvu@gft.com
      "marcingft",        # marcin.formela@gft.com
      "minhluong-gft",    # minh.luong@gft.com
      "mkonczak",         # marcin.konczak@gft.com
      "pawel-waclaw-gft", # pawel.waclaw@gft.com
      "petro-gft",        # petro.gnatyuk@gft.com
      "tamtrangft",       # tam.thanhtran@gft.com
      "tuanle-gft",       # tnsb@gft.com
      "vudo-gft",         # vu.anhdo@gft.com
    ]
  }
  nbo_be_team = {
    description = "NBO Backend Team",
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
  nbo_fe_team = {
    description = "NBO Frontend Team",
    maintainers = [
      "gftwally",   # waldemar.trawnicki@gft.com
      "michal-gft", # michal.przybylski@gft.com
    ],
    members = [
      "lamnguyengft",     # lam.hongnguyen@gft.com
      "minhluong-gft",    # minh.luong@gft.com
      "pawel-waclaw-gft", # pawel.waclaw@gft.com
      "tamtrangft",       # tam.thanhtran@gft.com
    ]
  }
  nbo_platform_team = {
    description = "NBO Team",
    maintainers = [
      "gftwally", # waldemar.trawnicki@gft.com
      "tylern91", # tyler.nguyen@gft.com
    ],
    members = [
      "diendoan-gft", # dien.doan@gft.com
      "longvu-gft",   # long.thanhvu@gft.com
      "vudo-gft",     # vu.anhdo@gft.com
    ]
  }
  # UDPN Teams
  udpn_team = {
    description = "UDPN Team",
    maintainers = [
      "tylern91", # tyler.nguyen@gft.com
    ],
    members = []
  }

  # UK Thought Machine Teams
  tmuk_team = {
    description = "TM UK GFT Team",
    maintainers = [
      "deanbrucewallis",     # dean.wallis@gft.com
      "jennifer-gft",        #jennifer.nicholas@gft.com
      "Rekha-Thimman-Gowda", # rekha.gowda@gft.com
      "SunkyGee",            # sunkanmi.gbajobi@gft.com
    ],
    members = []
  }

}

###################################################
# DEFINE WORKFLOWS CONFIGURATION HERE
###################################################

allowed_workflows_actions = [
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
]