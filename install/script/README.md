
# How to access cluster

## Add admin account
   
   rosa create admin --cluster=<clustername>

Takes few minutes to add account

## Access API server via CLI

    oc login https://api.<cluster FQDN>:443 --username cluster-admin --password <password>

## Access Console
   
    https://console-openshift-console.apps.rosa.<cluster FQDN>/dashboards


