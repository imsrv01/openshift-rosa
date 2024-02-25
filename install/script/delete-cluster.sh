# Delete cluster
rosa delete cluster --cluster=<clustername> --watch

# Delete operator role
rosa delete operator-roles --prefix <role perefix> --mode auto -y

# Delete OIDC config
rosa delete oidc-provider --oidc-config-id <ID> --mode auto -y
