SERVICE_ACCOUNT_EMAIL="${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com"
gcloud iam service-accounts create ${SERVICE_ACCOUNT_NAME} --display-name "${SERVICE_ACCOUNT_NAME}" --project "${PROJECT_ID}"
gcloud projects add-iam-policy-binding ${PROJECT_ID} --member "serviceAccount:${SERVICE_ACCOUNT_EMAIL}" --role "roles/compute.networkViewer"
gcloud projects add-iam-policy-binding ${PROJECT_ID} --member "serviceAccount:${SERVICE_ACCOUNT_EMAIL}" --role "roles/container.admin"
gcloud projects add-iam-policy-binding ${PROJECT_ID} --member "serviceAccount:${SERVICE_ACCOUNT_EMAIL}" --role "roles/iam.serviceAccountUser"
gcloud projects add-iam-policy-binding ${PROJECT_ID} --member "serviceAccount:${SERVICE_ACCOUNT_EMAIL}" --role "roles/iam.serviceAccountAdmin"

# Note a default service account
gcloud projects add-iam-policy-binding ${PROJECT_ID} --member "serviceAccount:${SERVICE_ACCOUNT_EMAIL}" --role "roles/compute.viewer"
gcloud projects add-iam-policy-binding ${PROJECT_ID} --member "serviceAccount:${SERVICE_ACCOUNT_EMAIL}" --role "roles/logging.logWriter"
gcloud projects add-iam-policy-binding ${PROJECT_ID} --member "serviceAccount:${SERVICE_ACCOUNT_EMAIL}" --role "roles/logging.admin"
gcloud projects add-iam-policy-binding ${PROJECT_ID} --member "serviceAccount:${SERVICE_ACCOUNT_EMAIL}" --role "roles/compute.networkAdmin"

# Enable services
gcloud services enable cloudresourcemanager.googleapis.com container.googleapis.com compute.googleapis.com --project ${PROJECT_ID}
# Create a Key
gcloud iam service-accounts keys create ${SERVICE_ACCOUNT_NAME} --iam-account ${SERVICE_ACCOUNT_EMAIL}

# Add Developers
gcloud projects add-iam-policy-binding ${PROJECT_ID} --member "user:peter.evan@gmail.com" --role "roles/container.developer"


