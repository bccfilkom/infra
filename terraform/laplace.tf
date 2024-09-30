resource "proxmox_vm_qemu" "laplace" {
  target_node = "bcc-dev"
  name        = "laplace-${count.index + 1}"
  desc        = "Project Laplace Server Instances"
  count       = 1

  clone = "ubuntu-cloud"

  agent = 1

  os_type = "cloud-init"
  cores   = 2
  sockets = 2
  numa    = true
  cpu     = "host"
  memory  = 2048

}
