sed -i.bak -e 's/CONFIG\(.*\)_PW=\(.*\)/CONFIG\1_PW=PW_PLACEHOLDER/'   -e 's/CONFIG\(.*\)_PASSWORD=\(.*\)/CONFIG\1_PASSWORD=PW_PLACEHOLDER/'   -e "s/CONFIG_CONTROLLER_HOST=.*/CONFIG_CONTROLLER_HOST={{ inventory_hostname }}/"   -e "s/CONFIG_COMPUTE_HOSTS.*/CONFIG_COMPUTE_HOSTS={{ groups['oscomp']|join(",") }}/"   -e "s/CONFIG_NETWORK_HOSTS.*/CONFIG_NETWORK_HOSTS={{ inventory_hostname }}/"   -e "s/CONFIG_STORAGE_HOST.*/CONFIG_STORAGE_HOST={{ inventory_hostname }}/"   -e "s/CONFIG_SAHARA_HOST.*/CONFIG_SAHARA_HOST={{ inventory_hostname }}/"   -e "s/CONFIG_AMQP_HOST.*/CONFIG_AMQP_HOST={{ inventory_hostname }}/"   -e "s/CONFIG_MARIADB_HOST.*/CONFIG_MARIADB_HOST={{ inventory_hostname }}/"   -e "s|CONFIG_KEYSTONE_LDAP_URL=ldap://.*|CONFIG_KEYSTONE_LDAP_URL=ldap://{{ inventory_hostname }}|"   -e "s/CONFIG_MONGODB_HOST=.*/CONFIG_MONGODB_HOST={{ inventory_hostname }}/"   -e "s/CONFIG_REDIS_MASTER_HOST=.*/CONFIG_REDIS_MASTER_HOST={{ inventory_hostname }}/"   answerfile