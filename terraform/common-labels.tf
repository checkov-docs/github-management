variable "labels" {
  default = {
    # Stop the search. Keep these alphabetibelized.

    "breaking-change" = {
      color       = "b60205",
      description = "Introduces a breaking change in current functionality; usually deferred to the next major release."
    },
    "bug" = {
      color       = "b60205",
      description = "Addresses a defect in current functionality."
    },
    "dependencies" = {
      color       = "0366d6",
      description = "Used to indicate dependency changes."
    },
    "documentation" = {
      color       = "0075ca",
      description = "Introduces or discusses updates to documentation."
    },
    "enhancement" = {
      color       = "0e8a16",
      description = "Requests to existing resources that expand the functionality or scope."
    },
    "examples" = {
      color       = "63d0ff",
      description = "Introduces or discusses updates to examples."
    },
    "needs-triage" = {
      color       = "e99695",
      description = "Waiting for first response or review from a maintainer."
    },
    "repository" = {
      color       = "587879",
      description = "Repository modifications; GitHub Actions, developer docs, issue templates, codeowners, changelog."
    },
    "tests" = {
      color       = "60dea9",
      description = "PRs: expanded test coverage. Issues: expanded coverage, enhancements to test infrastructure."
    },
    "size/XS" = {
      color       = "62d4dc",
      description = "Managed by automation to categorize the size of a PR."
    },
    "size/S" = {
      color       = "4ec3ce",
      description = "Managed by automation to categorize the size of a PR."
    },
    "size/M" = {
      color       = "3bb3c0",
      description = "Managed by automation to categorize the size of a PR."
    },
    "size/L" = {
      color       = "27a2b2",
      description = "Managed by automation to categorize the size of a PR."
    },
    "size/XL" = {
      color       = "1492a4",
      description = "Managed by automation to categorize the size of a PR."
    },
    "size/XXL" = {
      color       = "008196",
      description = "Managed by automation to categorize the size of a PR."
    },
  }
  description = "Name-color-description mapping of labels."
  type        = map(any)
}

locals {
  combined_list = flatten([
    for k, v in var.labels : [
      for r in var.repositories : {
        name        = k
        repository  = r
        color       = v.color
        description = v.description
      }
    ]
  ])
}

resource "github_issue_label" "workflow" {
  for_each = {
    for item in local.combined_list : "${item.repository}-${item.name}" => item
  }

  repository  = each.value.repository
  name        = each.value.name
  color       = each.value.color
  description = each.value.description
}
