#!/bin/bash

# Terraform Destroy Script
# Usage: ./destroy.sh <directory-name>
# Example: ./destroy.sh elasticsearch

set -e  # Exit on error

if [ -z "$1" ]; then
    echo "Error: No directory specified"
    echo "Usage: ./destroy.sh <directory-name>"
    echo "Example: ./destroy.sh elasticsearch"
    exit 1
fi

DIR="$1"

if [ ! -d "$DIR" ]; then
    echo "Error: Directory '$DIR' does not exist"
    exit 1
fi

echo "=========================================="
echo "Terraform Destroy - $DIR"
echo "=========================================="
echo ""

# Change to the specified directory
cd "$DIR"

# Check if terraform state exists
if [ ! -f "terraform.tfstate" ]; then
    echo "No terraform.tfstate file found in $DIR"
    echo "Either resources were never created or state file was removed."
    exit 1
fi

echo "WARNING: This will destroy all resources in $DIR!"
echo ""

# Show what will be destroyed
echo "Step 1: Planning destruction..."
terraform plan -destroy

echo ""
echo "Step 2: Destroying resources..."
read -p "Are you sure you want to destroy all resources? (yes/no): " confirm

if [ "$confirm" = "yes" ]; then
    terraform destroy -auto-approve
    echo ""
    echo "=========================================="
    echo "All resources destroyed successfully!"
    echo "=========================================="
else
    echo "Destroy cancelled."
    exit 0
fi
