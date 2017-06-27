#!/bin/sh
source /root/admin-openrc.sh


openstack user create --domain default --password neutron {{ NEUTRON_PASS }} &&\
openstack role add --project service --user neutron admin &&\
openstack service create --name neutron --description "OpenStack Networking" network &&\
openstack endpoint create --region RegionOne network public http://{{ NEUTRON }}:9696 &&\
openstack endpoint create --region RegionOne network internal http://{{ NEUTRON }}:9696 &&\
openstack endpoint create --region RegionOne network admin http://{{ NEUTRON }}:9696 &&\


