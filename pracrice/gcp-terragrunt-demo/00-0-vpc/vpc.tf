resource "google_compuet_network" "vpc" {
    name = vpc.vpc_name
    delete_default_routes_on_create = true
    auto_create_subnetworks = false
}

/**
 *https://developer.hashicorp.com/terraform/language/resources
 */
resource "google_compute_subnetwork" "rke-demo-subnet-001" {
    depends_on = [
       google_compuet_network.vpc
    ]

    name = "rke-demo-subnet-001"
    ip_cidr_range = "10.10.1.0/24"
    region = var.region
    network = var.vpc_name
}