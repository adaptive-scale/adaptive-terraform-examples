#!/bin/bash

# Terraform Apply Script
# Usage: ./apply.sh <directory-name>
# Example: ./apply.sh elasticsearch

set -e  # Exit on error

if [ -z "$1" ]; then
    echo "Error: No directory specified"
    echo "Usage: ./apply.sh <directory-name>"
    echo "Example: ./apply.sh elasticsearch"
    exit 1
fi

DIR="$1"

if [ ! -d "$DIR" ]; then
    echo "Error: Directory '$DIR' does not exist"
    exit 1
fi

echo "=========================================="
echo "Terraform Apply - $DIR"
echo "=========================================="
echo ""

# Change to the specified directory
cd "$DIR"

# Initialize Terraform
echo "Step 1: Initializing Terraform..."
terraform init -upgrade

echo ""
echo "Step 2: Validating Terraform configuration..."
terraform validate

echo ""
echo "Step 3: Planning Terraform changes..."
terraform plan

echo ""
echo "Step 4: Applying Terraform configuration..."
read -p "Do you want to proceed with apply? (yes/no): " confirm

if [ "$confirm" = "yes" ]; then
    terraform apply -auto-approve
    echo ""
    echo "=========================================="
    echo "Terraform apply completed successfully!"
    echo "=========================================="
else
    echo "Apply cancelled."
    exit 0
fi
