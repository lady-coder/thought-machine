# could be adjusted
region      = "eu-west-2"
environment = "tmuk-artifacts"
component   = "sync"

# please leave the below as it is
cidr_block      = "172.21.0.0/16"
public_subnets  = ["172.21.0.0/26", "172.21.0.64/26", "172.21.0.128/26"]
vpce_subnets    = ["172.21.40.128/26", "172.21.40.192/26"]
private_subnets = ["172.21.41.0/25", "172.21.41.128/25"]

# could be adjusted
L4_tags = {
  "blx:created-by"      = "terraform"
  "blx:owner"           = "all"
  "blx:tag-version"     = "1"
  "blx:repository-name" = "tf-thought-machine-artifacts"
}

# have to be updated to the proper value
ami_id = "ami-08722fffad032e569"

pipeline_stages = [
  {
    name             = "build",
    category         = "Build",
    owner            = "AWS",
    provider         = "CodeBuild",
    input_artifacts  = "SourceOutput",
    output_artifacts = "SyncOutput"
  },
  {
    name             = "verify",
    category         = "Build",
    owner            = "AWS",
    provider         = "CodeBuild",
    input_artifacts  = "SourceOutput",
    output_artifacts = "VerifyOutput"
  }
]
