/**
 * https://terragrunt.gruntwork.io/docs/getting-started/configuration/
 * https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/
 *
*/
locals {
    project = "nap-devops-non-prod"
    region = "asia-southeast1"
}

inputs = {
    project = locals.project
    region = locals.region
    vpc_name = "rke-demo-vpc"
    boot_disk_image = "projects/nap-devops-nonprod/global/images/ubuntu-20-develop"

    gce_manager_service_account = "gce-manager@${local.project}.iam.gserviceaccount.com"
    gce_rke_service_accont = "gce-rke@${local.project}.iam.gserviceaccount.com"

    rke_manager_ip = "10.10.1.100"
}

/**
 *
 * https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/#remote_state
*/
remote_state {
    backend = "gcs" 
    config = {
        bucket = "${local.project}-tf"
        prefix = path_relative_to_include()
        project = "${local.project}"
        location = "${local.region}"
    }
 }

/**
 *
 * https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/#generate
*/
generate "provider" {
    path = "provider.tf"
    
    if_exists = "overwrite_terragrunt"

    contents = <<EOF
        provider "google" {
            projct = "${local.project}"
            region = "${local.region}"
        }
        terraform {
            backend "gcs" {}
            required_providers {
                goole = "4.10.0"
            }
        }
    EOF
}
