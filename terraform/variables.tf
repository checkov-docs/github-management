variable "repositories" {
  description = "List of repositories to manage"
  type        = list(string)
  default     = ["checkov-docs"]
}
