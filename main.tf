provider "vsphere" {
  user           = var.user_name
  password       = var.password
  vsphere_server = var.vsphere_server_name

  # If you have a self-signed cert
  allow_unverified_ssl = true
}
data "vsphere_datacenter" "dc" {
  name = "LabDC"
}
data "vsphere_datastore_cluster" "datastore_cluster" {
  name          = "LabDSC"
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_datastore" "lun1" {
  name          = "Lab_Lun01"
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_resource_pool" "pool" {
  name          = "ers"
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_network" "network" {
  name          = "DPortGroup1043"
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_virtual_machine" "template" {
  name          = "templates/template-ubuntu-20.04"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# resource "vsphere_tag_category" "category" {
#   name        = "terraform-test-category"
#   cardinality = "SINGLE"
#   description = "Managed by Terraform"

#   associable_types = [
#     "VirtualMachine",
#     "Datastore",
#   ]
# }

# resource "vsphere_tag" "tag" {
#   name        = "terraform-test-tag"
#   category_id = "${vsphere_tag_category.category.id}"
#   description = "Managed by Terraform"
# }

resource "vsphere_virtual_machine" "vm" {
  count = var.instance_count
  name             = "nwc"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_cluster_id = data.vsphere_datastore_cluster.datastore_cluster.id
  folder           = "ers"
  num_cpus = 1
  memory   = 1024
  guest_id = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }
clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = "hello-world"
        domain    = "anadolu.edu.tr"
      }
      network_interface {
        ipv4_address    = "10.43.1.26"
        ipv4_netmask    = 22
        #dns_server_list = ["193.140.21.38", "212.175.41.103"]
        #network_id      = data.vsphere_network.network.id
  }
      ipv4_gateway    = var.gateway
      dns_server_list = var.dns_list
    }
  }

}