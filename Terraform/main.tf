terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}


provider "google" {
  project = "project-4856d338-1a84-4689-948"
  region  = "us-central1"
}


resource "google_artifact_registry_repository" "my_docker_repo" {
  location      = "us-central1"
  repository_id = "ai-counselor-repo"
  description   = "Docker repository for AI Counselor"
  format        = "DOCKER"
}


resource "google_cloud_run_v2_service" "my_app_service" {
  name     = "ai-counselor-service"
  location = "us-central1"
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      # Abhi ke liye ek dummy Google image, baad mein humari pipeline isko asli AI app se replace karegi
      image = "us-docker.pkg.dev/cloudrun/container/hello"
    }
  }
}


resource "google_cloud_run_v2_service_iam_member" "public_access" {
  name     = google_cloud_run_v2_service.my_app_service.name
  location = google_cloud_run_v2_service.my_app_service.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}