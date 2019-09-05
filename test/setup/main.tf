/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

# Random folder name suffix

resource "random_id" "folder-rand" {
  byte_length = 2
}

resource "google_folder" "ci_gke_folder" {
  display_name = "ci-tests-gke-folder-${random_id.folder-rand.hex}"
  parent       = "folders/${var.folder_id}"
}

module "gke_project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 3.0"

  name              = "ci-gke"
  random_project_id = true
  org_id            = var.org_id
  folder_id         = google_folder.ci_gke_folder.id
  billing_account   = var.billing_account

  activate_apis = [
    "admin.googleapis.com",
    "appengine.googleapis.com",
    "cloudbilling.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "oslogin.googleapis.com",
    "serviceusage.googleapis.com",
    "cloudkms.googleapis.com",
    "pubsub.googleapis.com",
    "storage-api.googleapis.com",
    "servicenetworking.googleapis.com",
    "storage-component.googleapis.com",
    "iap.googleapis.com",
  ]
}

