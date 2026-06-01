packer {
  required_plugins {
    qemu = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

source "qemu" "ubuntu" {

  vm_name = "ubuntu-kvm-packer"

  iso_url      = "ubuntu-26.04-live-server-amd64.iso"
  iso_checksum = "none"

  memory = 4096
  cpus   = 2

  firmware = "uefi"
  efi_boot = "true"
  efi_firmware_code = "/usr/share/OVMF/OVMF_CODE_4M.fd"
  efi_firmware_vars = "/usr/share/OVMF/OVMF_VARS_4M.fd"

  disk_size = "20000"

  format = "qcow2"

  accelerator = "kvm"

  communicator = "ssh"

  ssh_username = "ubuntu"
  ssh_password = "ubuntu"
  ssh_timeout  = "30m"

  http_directory = "http"

  boot_wait = "5s"

  boot_command = [
    "e<wait>",
    "<down><down><down>",
    "<end>",
    " autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/",
    "<f10>"
  ]

  shutdown_command = "echo ubuntu | sudo -S shutdown -P now"
}

build {
  sources = ["source.qemu.ubuntu"]

  provisioner "shell" {
    inline = [
      "echo 'Packer using KVM works!'",
      "sudo apt-get update",
      "sudo apt-get install -y curl git",
      "sudo apt-get -y autoremove"
    ]
  }
}
