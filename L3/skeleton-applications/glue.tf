module "glue" {
  source  = "spacelift.io/gft-blx/glue-registry/aws"
  version = "1.0.1"

  glue_registry_names = var.glue_registry_names
}
