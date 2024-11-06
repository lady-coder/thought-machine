# Automations for GitHub resources

- [Automations for GitHub resources](#automations-for-github-resources)
  - [Prerequisites](#prerequisites)
  - [Introduction](#introduction)
    - [Organization settings](#organization-settings)
    - [Repository creation and management](#repository-creation-and-management)
    - [Team creation and management](#team-creation-and-management)
  - [Recommendations](#recommendations)
  - [Known-issue](#known-issue)
    - [Allowing access to workflows in an internal repository](#allowing-access-to-workflows-in-an-internal-repository)

## Prerequisites

We use the pre-commit-hooks to control the code quality before commiting into our repository. It is required to install the below dependencies as prerequisites for the pre-commit hooks

```bash
brew install pre-commit tflint checkov
```

## Introduction

GitHub resources are managed by Terraform. This includes:

### Organization settings

- Members are not allowed to create the repository from the Github console.
- Members are not allowed to fork the private repositories.
- Members are not allowed to create the pages.
- Members are allowed to create the Issues.

### Repository creation and management

- `Private` repository visibility as default.
- Default branch as `main`, but provide the capability of changing to different branch.
- Branch protection rules for the `main` branch as default and additional feature branches.
- Only allow squash/rebase merge commits by default, enable auto merge for the Pull Request, delete branch on merge.
- Support repository archival on destroy as default.
- Squash merge commit from the Pull Request is the Pull Request's Title now
- Squash merge commit body message from the Pull Request is the the list of commits message in the PR.
- Only the specific team own the repository has the `write` privileges, all GFT members are now `triage` by default.
- Requires passing the below rules as prerequisite to merge the Pull Request:
  - All the conversations have been marked as `Resolved`
  - All the Checks must be passed
  - Require feature branch is up-to-date with target branch before merging.
  - Require commit signed with verified GPG Key
  - At least 1 approval from the CODEOWNER review

### Team creation and management

- Fine-grained RBAC adoptibility with the `maintainer` and `member` roles.

## Recommendations

Do not manage users, teams, or repositories via GitHub UI. It should be done only as a change through a Pull Request in this repository. All the changes will be managed by the [shared-service-automations-github](https://gft-blx.app.spacelift.io/stack/shared-service-automations-github) Spacelift stack.

Organization settings changes or repository deletion can be done by owners only.

## Known-issue

N/a

### Allowing access to workflows in an internal repository

As it is not possible to set access permissions to workflows in the internal repository from within terraform, it is necessary to set manually.

- On GitHub, navigate to the main page of the internal repository (github-workflows).
- Under your repository name github-workflows, click **Settings**.
- In the left sidebar, click **Actions**, then click **General**.
- Under **Actions permissions**, choose **Allow 'ORGANIZATION NAME' actions and reusable workflows**
