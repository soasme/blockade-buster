# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {}

variable "do_project_name" {
    default = "blockade-buster"
}
