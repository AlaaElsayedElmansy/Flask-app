#create new service account for gke
resource "google_service_account" "project-service-account" {
  account_id = "project-service-account"
  project = "alaa-376816"
}

#grant permissions for service account
resource "google_project_iam_binding" "project-service-account-iam" {
  project = "alaa-376816"
  role    = "roles/storage.admin"
  members = [
    "serviceAccount:${google_service_account.project-service-account.email}"
  ]
}