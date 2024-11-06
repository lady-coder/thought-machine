locals {
  alternative_protected_branch = compact(concat(formatlist(var.alternative_default_branch), tolist(var.additional_protected_branch)))
}
