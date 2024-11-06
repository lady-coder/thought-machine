package spacelift

# Access policy that will allow every member of the specific teams
# to get access to the stacks and modules.
# All of the example_team to get basic access

teams := input.session.teams

# Other Teams: Allow read access by default
read { teams[_] == "gft_engineers" }

# All members of the Github team below will get READ access:
# read { teams[_] == "example_team" }
