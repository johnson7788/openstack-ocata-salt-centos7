#!/bin/sh
rabbitmqctl add_user openstack {{ RABBIT_PASS }} && \
rabbitmqctl set_permissions openstack ".*" ".*" ".*" && \
rabbitmq-plugins enable rabbitmq_management && \
systemctl restart rabbitmq-server
