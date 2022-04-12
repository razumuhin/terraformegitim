variable "public_key_path"{
    type = string
}

variable "create_ssh_folder_script_path"{
    type = string
}

variable "admin_user_name"{
    type = string
}

variable "admin_password"{
    type = string
}

variable "user_name"{
    type = string
}

variable "password"{
    type = string
}

variable "vsphere_server_name"{
    type = string
}

variable "instance_count"{
    type = number
}

variable "gateway" {
  default = "10.43.1.0"
}

variable "dns_list" {
  default = "212.175.41.103"
}