#!/bin/bash

RESOURCE_GROUP="az204-bicep-rg"
LOCATION="southafricanorth"
TEMPLATE_FILE="main.bicep"       

if ! command -v az &> /dev/null
then
    echo "Azure CLI could not be found. Please install it before running this script."
    exit
fi

if ! /mnt/c/Program Files/Microsoft SDKs/Azure/CLI2/wbin/az account show &> /dev/null
then
    echo "You are not logged in. Please log in using 'az login'."
    az login
fi

if ! az group exists --name $RESOURCE_GROUP &> /dev/null
then
    echo "Creating resource group $RESOURCE_GROUP..."
    az group create --name $RESOURCE_GROUP --location $LOCATION
fi

echo "Deploying Bicep template..."
az deployment group create \
  --resource-group $RESOURCE_GROUP \
  --template-file $TEMPLATE_FILE

if [ $? -eq 0 ]; then
    echo "Deployment succeeded."
else
    echo "Deployment failed."
    exit 1
fi
