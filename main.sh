#!/usr/bin/env bash

set -e

# set necessarry environment variables
set_env(){
  export VAULT_ADDR="http://localhost:8200"
  export VAULT_TOKEN="root"
}

# enable LDAP auth method
enble_ldap_auth_method(){
  vault auth enable ldap
}

# configure LDAP auth method
configure_ldap_auth_method(){
  vault write auth/ldap/config \
   url="ldap://ldap_server:389" \
   binddn="cn=admin,dc=developerguy,dc=org" \
   bindpass="test1234" \
   userdn="ou=Users,dc=developerguy,dc=org" \
   userattr="cn" \
   groupdn="ou=Groups,dc=developerguy,dc=org" \
   groupattr="cn" \
   insecure_tls=false
}

# create necesarry policy bindings
create_policy_group_mapping(){
  vault policy write only-read-to-foo ./policy.hcl
  vault write auth/ldap/groups/Maintainers policies=only-read-to-foo
}

# login with ldap
login(){
 echo "Loginning with $@"
 vault login -method=ldap username="$@"
}


main(){
    set_env
    enble_ldap_auth_method
    configure_ldap_auth_method
    create_policy_group_mapping
    login "$@"
}


main "$@"

