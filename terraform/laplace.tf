resource "proxmox_vm_qemu" "laplace" {
  name        = "laplace-instance-${count.index + 1}"
  desc        = "Project Laplace Server Instances"
  target_node = "bcc-dev"
  clone       = "ubuntu24-cloud"
  count       = 4
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

  ipconfig0  = "ip=192.168.1.${count.index + 2}/24,gw=192.168.1.1"
  ciuser     = var.cloud_init_user
  cipassword = var.cloud_init_passwd
  sshkeys    = <<EOF
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPB4xBL5wKhqusJipjrsV+Peq1D7ge1G2EHJtaSLL5p2 dev@mrz.my.id
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj6EoGomhmaGhAGRncamehO73AeuLi8F2JU5ZaKJ78WzroLDk0IEAbf28YfCuSHJmAquWOFxA/h3Ch2O11KRO4YjGLraDEUW9D/Qolaij3TiXYqOGReYk5BQfVc5OmWK35BJhRsX4+4yAHrzUxM/lli90kDrlo21RSaaCsYbL+OZ59tngGJQX+5bpXcsqqTLs7teooyEVWULf3n2h/Qszu04KzL+FqoZG0LaeZPMqNiwno5Kvj6oh5JTMmrGQRL8rV/sSXMPsCiYGTDAePqEVTHM0WjLDFMiMuv9x1+mDwCSYT6mLWeYJhY8WiPvrM2yNQMnvTyuWpkRU7ap2OB/jGZ8cKMWTPytcfI4eG/+tfptORzUgmjaUQQ3SBPQr1IF57Mevs6LTH5q/I/bb1oOlEp1ouRckQoYg9ubFTJQ2zZPcm+RxTfT8l9EaN25mvkSzjs16FJAfPkH0UsziD13aiDBT6ppd7gp1nUDGX3xwP8Nr2HDoXP2HafiWpS05csK8= msi@DESKTOP-57RMF98
  EOF
}
