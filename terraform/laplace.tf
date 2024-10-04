variable "projects" {
  type = map(object({
    pubkey       = string
    host_segment = number
  }))
  default = {
    "career-path-ai" = {
      pubkey       = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj6EoGomhmaGhAGRncamehO73AeuLi8F2JU5ZaKJ78WzroLDk0IEAbf28YfCuSHJmAquWOFxA/h3Ch2O11KRO4YjGLraDEUW9D/Qolaij3TiXYqOGReYk5BQfVc5OmWK35BJhRsX4+4yAHrzUxM/lli90kDrlo21RSaaCsYbL+OZ59tngGJQX+5bpXcsqqTLs7teooyEVWULf3n2h/Qszu04KzL+FqoZG0LaeZPMqNiwno5Kvj6oh5JTMmrGQRL8rV/sSXMPsCiYGTDAePqEVTHM0WjLDFMiMuv9x1+mDwCSYT6mLWeYJhY8WiPvrM2yNQMnvTyuWpkRU7ap2OB/jGZ8cKMWTPytcfI4eG/+tfptORzUgmjaUQQ3SBPQr1IF57Mevs6LTH5q/I/bb1oOlEp1ouRckQoYg9ubFTJQ2zZPcm+RxTfT8l9EaN25mvkSzjs16FJAfPkH0UsziD13aiDBT6ppd7gp1nUDGX3xwP8Nr2HDoXP2HafiWpS05csK8= msi@DESKTOP-57RMF98"
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
