# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
source "vsphere-iso" "vm" {
  boot_command         = ["c", "setparams 'Preseed Install' <enter>", "set background_color=black <enter>", "linux /install.amd/vmlinuz ", "auto=true ", "priority=critical ", "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ", "vga=788 --- quiet <enter>", "initrd /install.amd/initrd.gz <enter>", "boot <enter>"]
  boot_order           = "disk,cdrom"
  boot_wait            = "5s"
  communicator         = "ssh"
  convert_to_template  = "true"
  CPUs                 = "${var.CPUs}"
  datacenter           = "${var.datacenter}"
  datastore            = "${var.datastore}"
  disk_controller_type = "pvscsi"
  folder               = "${var.folder}"
  guest_os_type        = "debian11_64Guest"
  host                 = "${var.host}"
  http_directory       = "./setup"
  insecure_connection  = "true"
  ip_wait_timeout      = "4h"
  iso_checksum         = "${var.iso_checksum}"
  iso_url              = "${var.mirror}/${var.mirror_directory}/${var.iso_name}"
  network_adapters {
    network      = "${var.network}"
    network_card = "vmxnet3"
  }
  password     = "${var.password}"
  RAM                  = "${var.RAM}"
  remove_cdrom = "true"
  ssh_password = "${var.ssh_password}"
  ssh_port     = 22
  ssh_timeout  = "60m"
  ssh_username = "${var.ssh_username}"
  storage {
    disk_size             = "${var.disk_size}"
    disk_thin_provisioned = true
  }
  tools_sync_time      = "true"
  tools_upgrade_policy = "true"
  username             = "${var.username}"
  vcenter_server       = "${var.vcenter_server}"
  vm_name              = "${var.vm_name}"
  vm_version           = 19
}

source "proxmox-iso" "vm" {
  boot         = ""
  boot_command = ["<up><tab> ip=dhcp inst.cmdline inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter>"]
  boot_wait    = "5s"
  cores        = "${var.cpus}"
  cpu_type     = "host"
  disks {
    disk_size         = "5G"
    storage_pool      = "local-lvm"
    type              = "scsi"
  }
  http_directory           = "./setup"
  insecure_skip_tls_verify = true
  iso_checksum             = "${var.iso_checksum}"
  iso_url                  = "${var.mirror}/${var.mirror_directory}/${var.iso_name}"
  memory                   = "${var.memory}"
  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
  }
  node                 = "my-proxmox"
  os                   = "l26"
  proxmox_url          = "https://my-proxmox.my-domain:8006/api2/json"
  qemu_agent           = true
  scsi_controller      = "virtio-scsi-pci"
  ssh_password         = "packer"
  ssh_port             = 22
  ssh_timeout          = "60m"
  ssh_username         = "root"
  token                = "my-proxmox-token"
  unmount_iso          = true
  username             = "${var.username}"
  vm_id                = "100"
  vm_name              = "${var.vm_name}"
}

source "vmware-iso" "vm" {
  boot_command         = ["<esc>auto preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter>"]
  boot_wait            = "5s"
  communicator         = "ssh"
  cpus                 = "${var.cpus}"
  disk_adapter_type    = "nvme"
  disk_size            = "${var.disk_size}"
  disk_type_id         = "${var.disk_type_id}"
  guest_os_type        = "debian11-64"
  headless             = false
  http_directory       = "./setup"
  iso_checksum         = "${var.iso_checksum}"
  iso_url              = "${var.mirror}/${var.mirror_directory}/${var.iso_name}"
  memory               = "${var.memory}"
  network              = "${var.network}"
  network_adapter_type = "${var.network_adapter_type}"
  output_directory     = "../../output/Debian_11_vmware"
  shutdown_command     = "echo 'vagrant'|sudo -S /sbin/halt -h -p"
  ssh_password         = "${var.ssh_password}"
  ssh_port             = 22
  ssh_timeout          = "60m"
  ssh_username         = "${var.ssh_username}"
  version              = 19
  vm_name              = "${var.vm_name}"
  vmx_remove_ethernet_interfaces = true
}

source "virtualbox-iso" "vm" {
  boot_command         = ["<esc>auto preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter>"]
  boot_wait            = "5s"
  communicator         = "ssh"
  cpus                 = "${var.cpus}"
  disk_size            = "${var.disk_size}"
  headless             = false
  http_directory       = "./setup"
  iso_checksum         = "${var.iso_checksum}"
  iso_url              = "${var.mirror}/${var.mirror_directory}/${var.iso_name}"
  memory               = "${var.memory}"
  output_directory     = "../../output/Debian_11_virtualbox"
  shutdown_command     = "echo 'vagrant'|sudo -S /sbin/halt -h -p"
  ssh_password         = "${var.ssh_password}"
  ssh_port             = 22
  ssh_timeout          = "60m"
  ssh_username         = "${var.ssh_username}"
  vm_name              = "${var.vm_name}"
  vboxmanage           = []
}
