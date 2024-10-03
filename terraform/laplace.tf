variable "projects" {
  type = map(object({
    pubkey       = string
    host_segment = number
  }))
  default = {
    "career-path-ai" = {
      pubkey       = ""
      host_segment = 2
    }
    "computy-ai" = {
      pubkey       = ""
      host_segment = 3
    }
    "mavis-summarizer" = {
      pubkey       = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO6qOQwZH6BEUIHVLrpjnBhwWHduqxUFeNkr5MOneD2B williamchen1506@gmail.com"
      host_segment = 4
    }
    "whale-ai" = {
      pubkey       = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFgVDBg82J/Gm49NMq/Nz29FxUXs+Wln77BKluaUeHEj radityanalaa@gmail.com"
      host_segment = 5
    }
  }
}

resource "proxmox_vm_qemu" "laplace" {
  for_each    = var.projects
  name        = "laplace-${each.key}"
  desc        = "Project Laplace Server Instances"
  target_node = "bcc-dev"
  clone       = "ubuntu24-cloud"
  agent       = 0
  full_clone  = true

  os_type = "cloud-init"
  cores   = 1
  memory  = 2048

  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"

  disks {
    scsi {
      scsi0 {
        disk {
          storage = "local-lvm"
          size    = 10
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

  ipconfig0  = "ip=192.168.1.${each.value.host_segment}/24,gw=192.168.1.1"
  ciuser     = var.cloud_init_user
  cipassword = var.cloud_init_passwd
  sshkeys    = <<EOF
    ${var.superkey}
    ${each.value.pubkey}
  EOF
}
