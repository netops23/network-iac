variable "common_tags" {
  type        = map(string)
  description = "Tags applied to everything in this lab."
  default = {
    environment = "lab"
    managed_by  = "terraform"
    purpose     = "module-learning"
  }
}
