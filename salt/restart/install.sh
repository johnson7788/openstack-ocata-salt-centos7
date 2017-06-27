openstack-nova-api:
  service.running:
    - name:
      - chronyd.service
      - httpd.service
      - mariadb.service
      - memcached.service
      - rabbitmq-server.service
      - openstack-nova-api.service
      - openstack-cinder-volume.service
      - lvm2-lvmetad.service
      - target.service
      - openstack-cinder-api.service
      - openstack-cinder-scheduler.service
      - openstack-glance-api.service
      - openstack-glance-registry.service
      - neutron-linuxbridge-agent.service
      - neutron-metadata-agent.service
      - openstack-nova-compute.service
      - openstack-nova-consoleauth.service
      - openstack-nova-scheduler.service
      - openstack-nova-conductor.service
      - openstack-nova-novncproxy.service
    - reload: True
    - enable: True

discover-compute-node:
  cmd.run:
    - name: su -s /bin/sh -c "nova-manage cell_v2 discover_hosts --verbose" nova
