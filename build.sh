#!/bin/bash

# Define variables
DOCKERHUB_USER="pranuthhm"
IMAGE_NAME="main_react_application_deployment_3"
IMAGE_TAG="dev-latest" # Using a dev tag for the dev branch

# Full image name
FULL_IMAGE_NAME="${DOCKERHUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}"

echo "--- Building Docker image: ${FULL_IMAGE_NAME} ---"

# Build the image using the Dockerfile in the current directory
docker build -t "${FULL_IMAGE_NAME}" .

# Check if the build was successful
if [ $? -eq 0 ]; then
  echo "--- Docker image built successfully ---"

  echo "--- Pushing image to Docker Hub ---"
  # Push the image to Docker Hub
  docker push "${FULL_IMAGE_NAME}"

  if [ $? -eq 0 ]; then
    echo "--- Image pushed to Docker Hub successfully ---"
  else
    echo "Error: Failed to push Docker image."
    exit 1
  fi
else
  echo "Error: Docker image build failed."
  exit 1
fi
