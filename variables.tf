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
    type = string
}

variable "dns_list" {
     type= list(string)
}