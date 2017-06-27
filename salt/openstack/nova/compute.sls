include:
  - openstack.env

nova-install:
  pkg.installed:
    - names:
       - openstack-nova-compute
       - python-openstackclient
       - openstack-utils
       - sysfsutils
  file.managed:
    - name: /etc/nova/nova.conf
    - source: salt://openstack/nova/files/nova-computer.conf
    - user: root
    - group: nova
    - mode: 640
    - template: jinja
    - defaults:
      MARIADB: {{ pillar['openstack']['MARIADB'] }}
      MEMCACHE: {{ pillar['openstack']['MEMCACHE'] }}
      RABBITMQ: {{ pillar['openstack']['RABBITMQ'] }}
      keystone: {{ pillar['openstack']['KEYSTONE'] }}
      GLANCE: {{ pillar['openstack']['GLANCE'] }}
      NEUTRON: {{ pillar['openstack']['NEUTRON'] }}
      CONTROLLER: {{ pillar['openstack']['CONTROLLER'] }}
      COMPUTE_NODE: {{ pillar['openstack']['COMPUTE_NODE'] }}
      NOVA_DBPASS: {{ pillar['password']['NOVA_DBPASS'] }}
      RABBIT_PASS: {{ pillar['password']['RABBIT_PASS'] }}
      NOVA_PLACEMENT_PASS: {{ pillar['password']['NOVA_PLACEMENT_PASS'] }}
      NOVA_PASS: {{ pillar['password']['NOVA_PASS'] }}
      NEUTRON_PASS: {{ pillar['password']['NEUTRON_PASS'] }}

nova-service:
    service.running:
    - names: 
      - libvirtd.service
      - openstack-nova-compute.service
    - enable: True      

