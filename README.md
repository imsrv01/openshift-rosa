# openshift-rosa

## Pre-req

- Download and setup ROSA cli

https://docs.redhat.com/en/documentation/red_hat_openshift_service_on_aws/4/html/rosa_cli/rosa-get-started-cli#rosa-get-started-cli


Install Manually from Binary
Download Terraform: Go to the official Terraform releases page:
👉 https://developer.hashicorp.com/terraform/downloads

Choose macOS (arm64 or amd64) depending on your Mac chip (M1/M2 = arm64).

Unzip the downloaded file:

  unzip terraform_<version>_darwin_<arch>.zip

Move the binary to a directory in your PATH:

  sudo mv terraform /usr/local/bin/
  
Check the version:

  terraform -v


## Install git

  xcode-select --install

  git --version

## ROSA Login

  rosa login
To login to your Red Hat account, get an offline access token at https://console.redhat.com/openshift/token/rosa
? Copy the token and paste it here: **********************************************************************************************************************************************************************************
I: Logged in as 'shan.vernekar@ibm.com' on 'https://api.openshift.com'


# STEPS

https://console.redhat.com/openshift/create/rosa/getstarted


  
