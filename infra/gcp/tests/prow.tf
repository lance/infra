// Prow Control Plane
resource "google_service_account_iam_binding" "prow_control_plane" {
  service_account_id = google_service_account.prow_control_plane.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "serviceAccount:knative-tests.svc.id.goog[default/crier]",
    "serviceAccount:knative-tests.svc.id.goog[default/deck]",
    "serviceAccount:knative-tests.svc.id.goog[default/sinker]",
  ]
}

resource "google_service_account" "prow_control_plane" {
  account_id   = "prow-control-plane"
  display_name = "Prow Control Plane"
  description  = "Service account used by Prow control plane to interact with Google services for the knative-tests project."
  project      = "knative-tests"
}


// External Secrets Operator
resource "google_service_account_iam_binding" "external_secrets" {
  service_account_id = google_service_account.external_secrets.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "serviceAccount:knative-tests.svc.id.goog[default/kubernetes-external-secrets-sa]",
    "serviceAccount:knative-tests.svc.id.goog[default/external-secrets]",
  ]
}

resource "google_service_account" "external_secrets" {
  account_id   = "kubernetes-external-secrets-sa"
  display_name = "External Secrets Operator"
  project      = "knative-tests"
}

// Pod Utils - This is the default service account used by all ProwJob Pods
resource "google_service_account_iam_binding" "prow_pod_utils" {
  service_account_id = google_service_account.prow_pod_utils.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "serviceAccount:knative-tests.svc.id.goog[default/default]",
    "serviceAccount:knative-tests.svc.id.goog[test-pods/default]",
  ]
}

resource "google_service_account" "prow_pod_utils" {
  account_id   = "prow-pod-utils"
  display_name = "Prow Pod Utilities"
  description  = "SA for Prow's pod utilities to use to upload job results to GCS."
  project      = "knative-tests"
}

// Prowjob Runner Account
resource "google_service_account_iam_binding" "prow_job" {
  service_account_id = google_service_account.prow_job.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "serviceAccount:knative-tests.svc.id.goog[test-pods/boskos]",
    "serviceAccount:knative-tests.svc.id.goog[test-pods/test-runner]",
  ]
}

resource "google_service_account" "prow_job" {
  account_id   = "prow-job"
  display_name = "Prow Job Knative Test Runner"
  project      = "knative-tests"
}