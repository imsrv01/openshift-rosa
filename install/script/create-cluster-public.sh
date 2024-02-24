
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
