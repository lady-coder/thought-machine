package spacelift

command := input.request.command

deny[sprintf("command not allowed (%s)", [command])] { not allowed }

allowed { input.session.admin }
allowed { re_match("^terraform\\s(un)?taint\\s[\\w\\-\\.]*$", command) }
allowed { re_match("^terraform\\simport\\s[\\w\\-\\.]*$", command) }
allowed { re_match("^terraform\\sapply", command) }
allowed { re_match("^terraform\\sdestroy", command) }
