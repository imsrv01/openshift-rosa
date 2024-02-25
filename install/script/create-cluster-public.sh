
# Create VPC and subnet
git clone https://github.com/openshift-cs/terraform-vpc-example
cd terraform-vpc-example
terraform init
terraform plan -out rosa.tfplan -var region=<region> [-var cluster_name=<cluster_name>]
terraform apply rosa.tfplan
export SUBNET_IDS=$(terraform output -raw cluster-subnets-string)
echo $SUBNET_IDS

# Create account wide role
rosa create account-roles --hosted-cp
ACCOUNT_ROLES_PREFIX="${ACCOUNT_ROLES_PREFIX}"
rosa create account-roles --hosted-cp --prefix $ACCOUNT_ROLES_PREFIX

# Create OIDC configuration
rosa create oidc-config --mode=auto  --yes
rosa list oidc-config

# Create operator role
OPERATOR_ROLES_PREFIX=<prefix_name>
rosa create operator-roles --hosted-cp --prefix $OPERATOR_ROLES_PREFIX --oidc-config-id $OIDC_ID --installer-role-arn arn:aws:iam::${AWS_ACCOUNT_ID}:role/${ACCOUNT_ROLES_PREFIX}-HCP-ROSA-Installer-Role

# Create cluster
rosa create cluster --cluster-name=<cluster_name> --sts --mode=auto --hosted-cp --operator-roles-prefix <operator-role-prefix> --oidc-config-id <ID-of-OIDC-configuration> --subnet-ids=<public-subnet-id>,<private-subnet-id>

# describe cluster
rosa describe cluster -c rosalab5

# Get logs
rosa logs install -c rosalab5 --watch


===

#!/bin/bash

# Declare variables
cluster_name=$1
region=$2
version=$3
role_prefix=$4
oidc_config_file=$5  # Added for OIDC config file output

# Login to ROSA CLI
rosa login

# Create OIDC configuration
rosa create oidc-config > $oidc_config_file

# Extract OIDC config ID from JSON output
oidc_config_id=$(jq -r '.oidcConfigId' $oidc_config_file)

# Create the cluster with OIDC config
rosa create cluster $cluster_name \
  --region=$region \
  --version=$version \
  --oidc-config-id=$oidc_config_id \
  # Add other desired options

# Create cluster-specific operator roles with prefix
rosa create operator-roles --prefix $role_prefix

# Wait for cluster creation and operator roles to be ready
rosa wait cluster --name $cluster_name --wait-ready

# Configure kubectl for cluster access
rosa configure kubectl $cluster_name

# Print cluster information
rosa describe cluster $cluster_name

====

./create_rosa_cluster.sh my-cluster us-east-1 4.13 my-roles oidc_config.json
