#!/bin/bash
set -e

PROJECT_NUMBER=$(gcloud projects list --filter="$(gcloud config get-value project)" --format="value(PROJECT_NUMBER)")

ENV=${1:-dev}
TF_STATE_BUCKET=tf-states-asia-southeast1-$PROJECT_NUMBER
TF_STATE_DYNAMODB_TABLE=tf-states-asia-southeast1-$PROJECT_NUMBER
export AWS_PAGER=""

if [[ "$ENV" != "dev" ]]; then
  TF_STATE_BUCKET=${TF_STATE_S3_BUCKET}-${ENV}
  TF_STATE_DYNAMODB_TABLE=${TF_STATE_DYNAMODB_TABLE}-${ENV}
fi
echo "bucket state: $TF_STATE_BUCKET"

terraform init -reconfigure -backend-config="bucket=${TF_STATE_BUCKET}"

ls ./env/${ENV}.tfvars
terraform plan -var-file=./env/${ENV}.tfvars 
terraform apply -var-file=./env/${ENV}.tfvars  
