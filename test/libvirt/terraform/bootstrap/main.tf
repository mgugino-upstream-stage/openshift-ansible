resource "libvirt_volume" "bootstrap" {
  name           = "${var.cluster_name}-bootstrap"
  base_volume_id = "${var.base_volume_id}"
}

resource "libvirt_cloudinit_disk" "bootstrapinit" {
  name           = "${var.cluster_name}-bs-init.iso"
  user_data      = templatefile("${path.module}/user-data.tpl", { ssh_authorized_keys = "${var.ssh_key}" })
}

resource "libvirt_domain" "bootstrap" {
  name = "${var.cluster_name}-bootstrap"

  memory = "2048"

  vcpu = "2"

  cloudinit = "${libvirt_cloudinit_disk.bootstrapinit.id}"
  disk {
    volume_id = "${libvirt_volume.bootstrap.id}"
  }

  console {
    type        = "pty"
    target_port = 0
  }

  network_interface {
    network_id = "${var.network_id}"
    hostname   = "${var.cluster_name}-bootstrap"
    addresses  = "${var.addresses}"
  }
}
