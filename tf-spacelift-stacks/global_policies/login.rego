package spacelift

# Login policy that will allow every member of the cloud_platform_devops_team to get admin access
# and all of the example_team to get basic access

teams := input.session.teams

# Cloud Teams: Admin access
admin { teams[_] == "cloud_platform_architecture_team" }
admin { teams[_] == "cloud_platform_devops_team" }

# Other Teams: Allow login access by default
allow { teams[_] == "gft_engineers" }

deny  { not input.session.member }
