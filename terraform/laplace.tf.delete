variable "projects" {
  type = map(object({
    pubkey       = string
    host_segment = number
    cores        = optional(number)
    memory       = optional(number)
  }))
  default = {
    "career-path-ai" = {
      pubkey       = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj6EoGomhmaGhAGRncamehO73AeuLi8F2JU5ZaKJ78WzroLDk0IEAbf28YfCuSHJmAquWOFxA/h3Ch2O11KRO4YjGLraDEUW9D/Qolaij3TiXYqOGReYk5BQfVc5OmWK35BJhRsX4+4yAHrzUxM/lli90kDrlo21RSaaCsYbL+OZ59tngGJQX+5bpXcsqqTLs7teooyEVWULf3n2h/Qszu04KzL+FqoZG0LaeZPMqNiwno5Kvj6oh5JTMmrGQRL8rV/sSXMPsCiYGTDAePqEVTHM0WjLDFMiMuv9x1+mDwCSYT6mLWeYJhY8WiPvrM2yNQMnvTyuWpkRU7ap2OB/jGZ8cKMWTPytcfI4eG/+tfptORzUgmjaUQQ3SBPQr1IF57Mevs6LTH5q/I/bb1oOlEp1ouRckQoYg9ubFTJQ2zZPcm+RxTfT8l9EaN25mvkSzjs16FJAfPkH0UsziD13aiDBT6ppd7gp1nUDGX3xwP8Nr2HDoXP2HafiWpS05csK8= msi@DESKTOP-57RMF98"
      host_segment = 2
    }
    "computy-ai" = {
      pubkey       = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCtLiDm5xeL+wGxhxG1zsiwL0B0+iFFQfqi5MLjM3JTZsh0KjfJDNKaUcBv9wFE9Q4PT12LTUTCHisDsY52vMmAwMS7ETuRjzvyFrTUhpFFFRUq+YjvrstPpiuy7GJtdX81k2rndleEG8v8muWcBeBWrgVC/bwjKpdNiD8Xw2xTY6gH+mhb8n0eCbT3alsRbQk/wilfHQtUHqLSt3XxJ8jlfzMKSwJvqbtZV7LW6p8/0K90d+0ul1UeLsC6dspBeW0w2NPbvP9QocJx6kHoMeve+PeUdi2+ejDcgIqZOTaplUnIm7osJzbP2CbOS2UCvoDT1dVq6NSicfTRmbcGcogieWrEVMCci1By8UJHs4X9frhysKduYYx+b8ySGY/uTZN735HfWoPB5lEyKiBX9qUXMrp0fnKsvrQYDp0H1aoqE924eBxEwIyzOlZ4c3HgFaL1vvXzAz0k2fcfzieYyI+r1Jsv4TqEUhCu14FpbIOnU2SMnGnpfVwomYe/Vgu9Clc= syahr@Syahreza"
      host_segment = 3
    }
    "mavis-summarizer" = {
      pubkey       = <<EOF
        ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDKwMhuTljm/04G8OiCmqLX+oO3JVNS0mvm7uFdiHZZ6QjZ2huLbXZJJIJUS+Pxkzv4PDypUhhg3yP42Eh5sRsumLIznExJacxIvAc40XgSkJCgMSmITLPvwIBcmsDnTPNwMCeCchuzpjx4CuuUUvO+EZmSJCV0XvQpzoQkbz+nhvFtE9xhk/THkI2GP5DJ6doQ5kYtfNu/1IjJRZXQNPV2IIlbr8Q4gBonCj7e4XleykT9qn7Wxyqx+AIvlS1zqKT5q+dfmxICJkoUxAeOFchIvGfqDWqYGbY4RXd3TzPlgdztYno/00fLFBr+r0gr4IEe39mHT79v4Cb5xLV7WpANvUTefyE3P0bkmef7DN3WZHbAvqAqypO4TbNK4dYGrSUTwckA3QpH/hgF/Td1OidvVH4E3h796LBVAGK2KSBybyuI4Trgpyd6VcszO2LtWuT+CN3fhYPjR9qICLpBqO3X6FS32HoQ5V50kagxtr75vtshSNLYNIFWRu7tpyLBxp/P2Y4kDwT9hN9JFREclq3sXD1UOEjcRXKp5TC5AexZoD8kThnQIA86tmzQiPr2a+R9Yrd9sBh0DTYTHiUBec70Yf9DBf2YWq8BvB7Sl6X3Sq1Y6PKxnGUlv77FU/tSJUCDe5ZSwlhdcXmMWL2unv0caQZJbWRL1ODi+7XZAANN4Q== ryzen@DESKTOP-U3JP8OL
        ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO6qOQwZH6BEUIHVLrpjnBhwWHduqxUFeNkr5MOneD2B williamchen1506@gmail.com"
      EOF
      host_segment = 4
      cores        = 2
      memory       = 4096
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
  cores   = each.value.cores != null ? each.value.cores : 1
  memory  = each.value.memory != null ? each.value.memory : 2048

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
