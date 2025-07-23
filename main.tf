provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

# Variables
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "compartment_ocid" {}

variable "availability_domains" {
  type    = list(string)
  default = ["AD-1", "AD-2", "AD-3"]
}

# Get the latest Ubuntu ARM image
data "oci_core_images" "ubuntu_arm" {
  compartment_id = var.compartment_ocid

  operating_system         = "Canonical Ubuntu"
  operating_system_version = "22.04"
  shape                    = "VM.Standard.A1.Flex"
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

# Get available ADs (optional)
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

# Launch instance
resource "oci_core_instance" "arm_instance" {
  count               = 1
  availability_domain = element(var.availability_domains, 0) # Start with AD-1
  compartment_id      = var.compartment_ocid

  shape = "VM.Standard.A1.Flex"

  shape_config {
    ocpus         = 1
    memory_in_gbs = 6
  }

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.ubuntu_arm.images[0].id
  }

  display_name = "auto-retry-arm-instance"

  metadata = {
    ssh_authorized_keys = file("~/.ssh/id_rsa.pub")
  }
}
