#!/bin/sh
source /root/admin-openrc.sh


openstack user create --domain default --password=cinder {{ CINDER_PASS }}
openstack role add --project service --user cinder admin
openstack service create --name cinderv2   --description "OpenStack Block Storage" volumev2
openstack service create --name cinderv3   --description "OpenStack Block Storage" volumev3
openstack endpoint create --region RegionOne volumev2 public http://{{ CINDER }}:8776/v2/%\(project_id\)s
openstack endpoint create --region RegionOne volumev2 internal http://{{ CINDER }}:8776/v2/%\(project_id\)s
openstack endpoint create --region RegionOne volumev2 admin http://{{ CINDER }}:8776/v2/%\(project_id\)s
openstack endpoint create --region RegionOne volumev3 public http://{{ CINDER }}:8776/v3/%\(project_id\)s
openstack endpoint create --region RegionOne volumev3 internal http://{{ CINDER }}:8776/v3/%\(project_id\)s
openstack endpoint create --region RegionOne volumev3 admin http://{{ CINDER }}:8776/v3/%\(project_id\)s

