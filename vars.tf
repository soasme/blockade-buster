variable "do_token" {
}

variable "do_project_name" {
  default = "blockade-buster"
}

variable "do_ssh_keys" {
  type = "list"
}

variable "do_ssh_private_key" {}

variable "ss_server_port" {
  default = 8080
}

variable "ss_timeout" {
  default = 300
}

variable "ss_nameserver" {
  default = "8.8.8.8"
}

variable "ss_method" {
  default = "chacha20"
}

variable "ss_password" {}
