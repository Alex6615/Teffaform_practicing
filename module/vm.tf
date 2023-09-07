variable "vm_count" {
  description = "Number of VM instances to create."
  type        = number
  default     = 2
}

variable "my_project" {
  type    = string
  default = // project ID
}

variable "my_zone" {
  type    = string
  default = "asia-south1-a"
}

variable "my_region" {
  type    = string
  default = "asia-south1"
}

resource "google_compute_instance" "vm" {
  count        = var.vm_count
  name         = "my-test-vm-${count.index}"
  machine_type = "e2-small"
  project      = var.my_project
  zone         = var.my_zone  # Change to your desired zone
  # Add other instance configuration here...
  boot_disk {
        auto_delete = true
        mode        = "READ_WRITE"

        initialize_params {
            image  = "https://www.googleapis.com/compute/v1/projects/debian-cloud/global/images/debian-11-bullseye-v20230814"
            labels = {
                "my_label" = "value"
            }
            size   = 10
            type   = var.project_id
        }
    }
  network_interface {
        stack_type         = "IPV4_ONLY"
        subnetwork         = f"https://www.googleapis.com/compute/v1/projects/${var.my_project}/regions/${var.my_region}/subnetworks/default"
        subnetwork_project = var.my_project
        access_config {
      // Use an ephemeral IP address
        }
    }

}