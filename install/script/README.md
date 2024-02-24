
# How to access cluster

1) Add admin account
   
    rosa create admin --cluster=<clustername>

Takes few minutes to add account

2) Access API server via CLI

    oc login https://api.<cluster FQDN>:443 --username cluster-admin --password <password>

3) Access Console
   
    https://console-openshift-console.apps.rosa.<cluster FQDN>/dashboards


