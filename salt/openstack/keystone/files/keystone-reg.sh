#!/bin/sh

keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
keystone-manage credential_setup --keystone-user keystone --keystone-group keystone

keystone-manage bootstrap --bootstrap-password {{ KEYSTONE_ADMIN_PASS }} \
--bootstrap-admin-url http://{{ KEYSTONE }}:35357/v3/ \
--bootstrap-internal-url http://{{ KEYSTONE }}:5000/v3/ \
--bootstrap-public-url http://{{ KEYSTONE }}:5000/v3/ \
--bootstrap-region-id RegionOne

export OS_USERNAME=admin
export OS_PASSWORD={{ KEYSTONE_ADMIN_PASS }}
export OS_PROJECT_NAME=admin
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_DOMAIN_NAME=Default
export OS_AUTH_URL=http://{{ KEYSTONE }}:35357/v3
export OS_IDENTITY_API_VERSION=3

openstack project create --domain default --description "Service Project" service &&\
openstack project create --domain default --description "Demo Project" demo &&\
openstack user create --domain default --password demo {{ KEYSTONE_DEMO_PASS }} &&\
openstack role create user &&\
openstack role add --project demo --user demo user

unset OS_AUTH_URL OS_PASSWORD

openstack --os-auth-url http://{{ KEYSTONE }}:35357/v3 \
--os-project-domain-name default --os-user-domain-name default \
--os-project-name admin --os-username admin token issue &&\
openstack --os-auth-url http://{{ KEYSTONE }}:5000/v3 \
--os-project-domain-name default --os-user-domain-name default \
--os-project-name demo --os-username demo token issue &&\




