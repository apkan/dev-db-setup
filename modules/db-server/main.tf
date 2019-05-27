resource "google_compute_instance" "db_server" {
  name           = "${var.db_server_name}"
  machine_type   = "${var.db_server_machine_type}"
  zone           = "${var.db_server_zone}"

  tags = [ "devdb" ]

  boot_disk {
    initialize_params {
      image = "${var.db_server_image}"
      size  = "${var.db_server_disk_size}"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    Name     = "Dev DB Server"
    ssh-keys = "${var.ssh_user}:${file("${var.public_key_path}")}"
  }

  provisioner "remote-exec" {
    inline = ["echo 'Setting up dev DB server!'"]

    connection {
      type        = "ssh"
      user        = "${var.ssh_user}"
      private_key = "${file("${var.private_key_path}")}"
    }
  }
}

data "template_file" "inventory" {
  template = "${file("inventory.tpl")}"
  depends_on = [ "google_compute_instance.db_server" ]

  vars {
    host_ip = "${google_compute_instance.db_server.network_interface.0.access_config.0.nat_ip}"
  }

  depends_on = ["google_compute_instance.db_server"]
}

resource "local_file" "inventory" {
  content = "${data.template_file.inventory.rendered}"
  filename = "./ansible/inventory.yml"
}

resource "null_resource" "inventory" {
  triggers {
    template = "${data.template_file.inventory.rendered}"
  }

  provisioner "local-exec" {
    command = "ansible-playbook  -i ./ansible/inventory.yml --private-key ${var.private_key_path} ./ansible/dbServer.yml"
  }
}
