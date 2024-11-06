package spacelift

track {
    affected
    input.push.branch == input.stack.branch
}
propose { affected }
ignore  { not affected }

affected {
    some i, j, k

    tracked_directories := {input.stack.project_root}
    tracked_extensions := {".tf", ".tfvars", ".tf.json"}

    path := input.push.affected_files[i]

    startswith(path, tracked_directories[j])
    endswith(path, tracked_extensions[k])
}
