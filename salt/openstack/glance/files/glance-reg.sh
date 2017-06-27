#!/bin/sh
source /root/admin-openrc.sh

openstack user create --domain default --password glance {{ GLANCE_PASS }} &&\
openstack role add --project service --user glance admin  &&\
openstack service create --name glance --description "OpenStack Image" image &&\
openstack endpoint create --region RegionOne  image public http://{{ GLANCE }}:9292  &&\
openstack endpoint create --region RegionOne  image internal http://{{ GLANCE }}:9292 &&\
openstack endpoint create --region RegionOne  image admin http://{{ GLANCE }}:9292


