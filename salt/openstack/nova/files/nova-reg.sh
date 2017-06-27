#!/bin/sh
source /root/admin-openrc.sh

openstack user create --domain default --password nova {{ NOVA_PASS }}
openstack role add --project service --user nova admin
openstack service create --name nova --description "OpenStack Compute" compute
openstack endpoint create --region RegionOne compute public http://{{ NOVA }}:8774/v2.1
openstack endpoint create --region RegionOne compute internal http://{{ NOVA }}:8774/v2.1
openstack endpoint create --region RegionOne compute admin http://{{ NOVA }}:8774/v2.1
openstack user create --domain default --password placement {{ NOVA_PLACEMENT_PASS }}
openstack role add --project service --user placement admin
openstack service create --name placement --description "Placement API" placement
openstack endpoint create --region RegionOne placement public http://{{ NOVA }}:8778
openstack endpoint create --region RegionOne placement internal http://{{ NOVA }}:8778
openstack endpoint create --region RegionOne placement admin http://{{ NOVA }}:8778

