# provider "aws" {
#   region = "us-west-2"  # Replace with the region you want to check
# }

data "aws_regions" "available_regions" {
  allow_regions = []
}

resource "null_resource" "check_region" {
  depends_on = [data.aws_regions.available_regions]

  provisioner "local-exec" {
    command = <<-EOT
      if [[ -z $(terraform output -raw aws_regions.available_regions["${var.region}"]) ]]; then
        echo "Region ${var.region} is not available."
      else
        echo "Region ${var.region} is available."
      fi
    EOT
  }
}

output "region_availability" {
  value = null_resource.check_region.id
}
