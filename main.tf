provider "google" {
  project     = "${var.project}"
  region      = "${var.region}"
}

module "db-server" {
  source                  = "modules/db-server"

  ssh_user                = "${var.ssh_user}"
  public_key_path         = "${var.public_key_path}"
  private_key_path        = "${var.private_key_path}"
  db_server_name          = "${var.db_server_name}"
  db_server_machine_type  = "${var.db_server_machine_type}"
  db_server_zone          = "${var.db_server_zone}"
  db_server_image         = "${var.db_server_image}"
  db_server_disk_size     = "${var.db_server_disk_size}"
}
