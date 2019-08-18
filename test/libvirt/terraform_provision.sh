#!/bin/bash

cd terraform
terraform init
terraform 0.12upgrade
terraform apply -auto-approve
