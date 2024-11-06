region     = "eu-central-1"
github_org = "gft-blx"

spacelift_runner_image = "336241431902.dkr.ecr.eu-central-1.amazonaws.com/spacelift/terraform-runner:v1.4.1_20230911"

stacks = [
  # BLX Workspaces
  {
    repository        = "tf-sandbox-apps-infra",
    environment       = "sandbox",
    component         = "apps",
    context           = "infra",
    worker_pool_name  = "sandbox-apps-worker-pool",
    region            = "",
    terraform_version = "1.3.2",
    project_root      = "",
    additional_after_init_commands = [
      "checkov -d . --framework=terraform --quiet",
    ]
  },
  {
    repository        = "tf-shared-services-infra",
    environment       = "shared-service",
    component         = "ci",
    context           = "infra",
    worker_pool_name  = "shared-service-ci-worker-pool",
    region            = "",
    terraform_version = "1.5.7",
    project_root      = "",
    additional_after_init_commands = [
      "checkov -d . --framework=terraform --config-file .checkov.yaml --quiet",
    ]
  },
  {
    repository        = "tf-automations-github",
    environment       = "shared-service",
    component         = "automations",
    context           = "github",
    worker_pool_name  = "shared-service-ci-worker-pool",
    region            = "",
    terraform_version = "1.5.7",
    project_root      = "",
    additional_after_init_commands = [
      "checkov -d . --framework=terraform --quiet",
    ]
  },
  {
    repository        = "tf-sandbox-data-infra",
    environment       = "sandbox",
    component         = "data",
    context           = "infra",
    worker_pool_name  = "sandbox-apps-worker-pool",
    region            = "",
    terraform_version = "1.3.2",
    project_root      = "",
    additional_after_init_commands = [
      "checkov -d . --framework=terraform --quiet",
    ]
  },
  {
    repository        = "tf-sandbox-apps-observability",
    environment       = "sandbox",
    component         = "apps",
    context           = "observability",
    worker_pool_name  = "sandbox-apps-worker-pool",
    region            = "",
    terraform_version = "1.3.2",
    project_root      = "",
    additional_after_init_commands = [
      "checkov -d . --framework=terraform --quiet",
    ]
  },
  {
    repository        = "tf-shared-services-observability",
    environment       = "shared-services",
    component         = "ci",
    context           = "observability",
    worker_pool_name  = "shared-service-ci-worker-pool",
    region            = "",
    terraform_version = "1.3.2",
    project_root      = "",
    additional_after_init_commands = [
      "checkov -d . --framework=terraform --quiet",
    ]
  },
  {
    repository        = "tf-sandbox-tm-infra",
    environment       = "sandbox",
    component         = "tm",
    context           = "infra",
    worker_pool_name  = "sandbox-tm-worker-pool",
    region            = "",
    terraform_version = "1.3.2",
    project_root      = "",
    additional_after_init_commands = [
      "checkov -d . --framework=terraform --quiet",
    ]
  },
  # DigitalEye Stacks
  {
    repository        = "nbo-tf-environment",
    environment       = "nbo",
    component         = "apps",
    context           = "infra",
    worker_pool_name  = "sandbox-apps-worker-pool",
    region            = "",
    terraform_version = "1.5.7",
    project_root      = "dev/infrastructure",
    additional_after_init_commands = [
      "checkov -d . --framework=terraform --config-file .checkov.yaml --quiet",
    ]
  },
  {
    repository        = "nbo-tf-environment",
    environment       = "nbo",
    component         = "apps",
    context           = "networking",
    worker_pool_name  = "sandbox-apps-worker-pool",
    region            = "",
    terraform_version = "1.5.7",
    project_root      = "dev/networking",
    additional_after_init_commands = [
      "checkov -d . --framework=terraform --config-file .checkov.yaml --quiet",
    ]
  },
  {
    repository        = "nbo-tf-environment",
    environment       = "nbo",
    component         = "apps",
    context           = "observability",
    worker_pool_name  = "sandbox-apps-worker-pool",
    region            = "",
    terraform_version = "1.5.7",
    project_root      = "dev/observability",
    additional_after_init_commands = [
      "checkov -d . --framework=terraform --config-file .checkov.yaml --quiet",
    ]
  },
  {
    repository        = "nbo-tf-environment",
    environment       = "nbo",
    component         = "apps",
    context           = "prerequisites",
    worker_pool_name  = "sandbox-apps-worker-pool",
    region            = "",
    terraform_version = "1.5.7",
    project_root      = "dev/prerequisites",
    additional_after_init_commands = [
      "checkov -d . --framework=terraform --config-file .checkov.yaml --quiet",
    ]
  },


  {
    repository        = "tmuk-tf-sandbox-tm-infra",
    environment       = "sandbox",
    component         = "tmuk",
    context           = "infra",
    worker_pool_name  = "sandbox-tmuk-worker-pool",
    region            = "",
    terraform_version = "1.5.7",
    project_root      = "",
    additional_after_init_commands = [
      "checkov -d . --framework=terraform --quiet",
    ]
  },
  {
    repository        = "tmuk-tf-sandbox-tm-networking",
    environment       = "sandbox",
    component         = "tmuk",
    context           = "networking",
    worker_pool_name  = "sandbox-tmuk-worker-pool",
    region            = "",
    terraform_version = "1.5.7",
    project_root      = "",
    additional_after_init_commands = [
      "checkov -d . --framework=terraform --quiet",
    ]
  },
  {
    repository        = "tmuk-tf-infra-maintenance",
    environment       = "sandbox",
    component         = "tmuk",
    context           = "infra-maintenance",
    worker_pool_name  = "sandbox-tmuk-worker-pool",
    region            = "",
    terraform_version = "1.5.7",
    project_root      = "",
    additional_after_init_commands = [
      "checkov -d . --framework=terraform --quiet",
    ]
  },

  {
    repository        = "tmukextn-tf-sandbox-tm-networking",
    environment       = "sandbox",
    component         = "tmukextn",
    context           = "networking",
    worker_pool_name  = "sandbox-tmukextn-worker-pool",
    region            = "",
    terraform_version = "1.5.7",
    project_root      = "",
    additional_after_init_commands = [
      "checkov -d . --framework=terraform --quiet",
    ]
  }

]
