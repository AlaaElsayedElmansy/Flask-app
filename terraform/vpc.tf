resource "google_compute_network" "vpc" {
  name                    = "vpc"
  project                 = "alaa-376816"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"

}
#create management subnet for VM
resource "google_compute_subnetwork" "management_subnet" {
  name          = "management-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region        = "us-west1"
  network       = google_compute_network.vpc.id
}

#create restricted subnet for GKE
resource "google_compute_subnetwork" "restricted_subnet" {
  name          = "restricted-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-west1"
  network       = google_compute_network.vpc.id

  #allow private google access to communicate with gcp resources
  private_ip_google_access = true
}