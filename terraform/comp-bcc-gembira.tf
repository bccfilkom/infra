resource "proxmox_vm_qemu" "comp-bcc-gembira" {
  name        = "bcc-gembira"
  desc        = "BCC Gembira - UC"
  target_node = "bcc-dev"
  clone       = "ubuntu24-cloud"
  agent       = 0
  full_clone  = true

  os_type = "cloud-init"
  cores   = 1
  sockets = 2
  memory  = 2048
  numa    = true

  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"

  disks {
    scsi {
      scsi0 {
        disk {
          storage = "local-lvm"
          size    = 32
        }
      }
    }
    ide {
      ide2 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }

  ipconfig0  = "ip=192.168.10.2/24,gw=192.168.1.1"
  ciuser     = var.cloud_init_user
  cipassword = var.cloud_init_passwd
  sshkeys    = <<EOF
        ${var.superkey}
    EOF
}
