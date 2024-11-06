region                      = "eu-west-2"
environment                 = "sandbox"
component                   = "tm"
elastic_ip_identifiers      = ["ngw"]
spacelift_ec2_ami_id        = "ami-0656ca399782f7b41" # eu-west-2
spacelift_ec2_instance_type = "t3a.medium"
domain                      = "gft-aws.com"
subdomain                   = "tmuk"

L4_tags = {
  "blx:created-by"      = "terraform"
  "blx:owner"           = "tmuk"
  "blx:tag-version"     = "1"
  "blx:repository-name" = "tmuk-tf-sandbox-tm-networking"
}
