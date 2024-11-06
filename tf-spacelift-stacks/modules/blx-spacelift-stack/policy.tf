resource "spacelift_policy_attachment" "access" {
  policy_id = var.spacelift_access_policy_id
  stack_id  = spacelift_stack.this.id
}

resource "spacelift_policy_attachment" "push" {
  policy_id = var.spacelift_push_policy_id
  stack_id  = spacelift_stack.this.id
}

resource "spacelift_policy_attachment" "task" {
  policy_id = var.spacelift_task_policy_id
  stack_id  = spacelift_stack.this.id
}
