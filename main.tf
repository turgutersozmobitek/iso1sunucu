#bir oluşturalım 

resource "vcd_vapp_org_network" "vappOrgNet" {
  org = var.org_name
  vdc = var.vdc_name
  vapp_name = var.vapp_name

  # Comment below line to create an isolated vApp network
  org_network_name = var.org_network_name
}


resource "vcd_independent_disk" "disk1" {
  org          = var.org_name
  vdc          = var.vdc_name
  name         = var.vm_disk_name
  size_in_mb   = var.vm_disk_size
  bus_type     = "SCSI"
  bus_sub_type = "VirtualSCSI"
}




resource "vcd_vapp_vm" "web1" {
  vapp_name        = var.vapp_name
  name             = var.vm_name
  computer_name    = var.computer_name
  catalog_name     = var.catalog_name
  os_type          = var.os_family
  hardware_version = "vmx-14"
  boot_image       = var.boot_image
  memory           = var.vm_memory
  cpus             = var.vm_cpu
  cpu_cores        = var.vm_cpu_core
  cpu_hot_add_enabled=true
  memory_hot_add_enabled=true
  power_on=false

    disk {
    name        = var.vm_disk_name
    bus_number  = 1
    unit_number = 0
  }
  


  network {
    type               = "org"
    name               = var.org_network_name
    ip_allocation_mode = "MANUAL"
    ip                 = var.vm_ip
    adapter_type       = var.adapter_type
    is_primary         = true
  }

   customization{
      enabled=false
    }


}
