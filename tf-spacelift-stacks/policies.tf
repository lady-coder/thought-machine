# LOGIN POLICY
resource "spacelift_policy" "login" {
  type = "LOGIN"

  name = "Cloud Platform members are admins"
  body = file("${path.module}/global_policies/login.rego")
}

# ACCESS POLICY
resource "spacelift_policy" "access" {
  type = "ACCESS"

  name = "Access Policies for Spacelift Stacks and Modules"
  body = file("${path.module}/global_policies/access.rego")
}

# PUSH POLICY
# This Git push policy ignores all changes that are outside a project's
# root. Other than that, it follows the defaults - pushes to the tracked branch
# trigger tracked runs, pushes to all other branches trigger proposed runs, tag
# pushes are ignored.
resource "spacelift_policy" "push" {
  type = "GIT_PUSH"

  name = "Ignore commits outside the project root"
  body = file("global_policies/push.rego")
}

# TASK POLICY
# This task policy only allows you to execute a few selected commands.
resource "spacelift_policy" "task" {
  type = "TASK"

  name = "Allow only safe commands"
  body = file("global_policies/task.rego")
}
