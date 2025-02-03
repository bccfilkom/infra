
resource "proxmox_vm_qemu" "depart-cp" {
  name        = "department-cp"
  desc        = "Competitive Programming Basic Computing Community Company"
  target_node = "bcc-dev"
  clone       = "ubuntu24-cloud"
  agent       = 0
  full_clone  = true

  os_type = "cloud-init"
  cores   = 2
  sockets = 2
  memory  = 8192
  numa    = true

  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"

  disks {
    scsi {
      scsi0 {
        disk {
          storage = "local-lvm"
          size    = 40
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

  ipconfig0  = "ip=192.168.1.7/24,gw=192.168.1.1"
  ciuser     = var.cloud_init_user
  cipassword = var.cloud_init_passwd
  sshkeys    = <<EOF
    ${var.superkey}
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINrvRVRIzXaoNBOxYc8QYUzE955o02pHRH+tbsc15O0A ferrelvsc20@gmail.com
  EOF
}
