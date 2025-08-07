#!/bin/bash

# Define variables
DOCKERHUB_USER="pranuthhm"
IMAGE_NAME="main_react_application_deployment_3"
IMAGE_TAG="dev-latest" # Using a dev tag for the dev branch
CONTAINER_NAME="react-app-container"

# Full image name
FULL_IMAGE_NAME="${DOCKERHUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}"

echo "--- Starting deployment process ---"

# Pull the latest image from Docker Hub
echo "Pulling latest Docker image: ${FULL_IMAGE_NAME}"
docker pull "${FULL_IMAGE_NAME}"

if [ $? -ne 0 ]; then
  echo "Error: Failed to pull Docker image."
  exit 1
fi

# Stop and remove any existing container with the same name
echo "Stopping and removing existing container (if any)..."
docker stop "${CONTAINER_NAME}" || true
docker rm "${CONTAINER_NAME}" || true

# Run the new container, mapping port 80 to 80
echo "Running new container..."
docker run -d \
  --name "${CONTAINER_NAME}" \
  -p 80:80 \
  "${FULL_IMAGE_NAME}"

if [ $? -eq 0 ]; then
  echo "Application deployed successfully. Access it on port 80."
else
  echo "Error: Failed to deploy the application."
  exit 1
fi
