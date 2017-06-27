include:
  - openstack.env

nova-install:
  pkg.installed:
    - names:
       - openstack-nova-api
       - openstack-nova-placement-api
       - openstack-nova-cert
       - openstack-nova-conductor
       - openstack-nova-console
       - openstack-nova-novncproxy
       - openstack-nova-scheduler
       - python2-novaclient
  file.managed:
    - name: /etc/nova/nova.conf
    - source: salt://openstack/nova/files/nova.conf
    - user: root
    - group: nova
    - mode: 640
    - template: jinja
    - defaults:
      MARIADB: {{ pillar['openstack']['MARIADB'] }}
      MEMCACHE: {{ pillar['openstack']['MEMCACHE'] }}
      RABBITMQ: {{ pillar['openstack']['RABBITMQ'] }}
      KEYSTONE: {{ pillar['openstack']['KEYSTONE'] }}
      GLANCE: {{ pillar['openstack']['GLANCE'] }}
      NEUTRON: {{ pillar['openstack']['NEUTRON'] }}
      NOVA: {{ pillar['openstack']['NOVA'] }}
      CONTROLLER: {{ pillar['openstack']['CONTROLLER'] }}
      NOVA_DBPASS: {{ pillar['password']['NOVA_DBPASS'] }}
      RABBIT_PASS: {{ pillar['password']['RABBIT_PASS'] }}
      NOVA_PLACEMENT_PASS: {{ pillar['password']['NOVA_PLACEMENT_PASS'] }}
      NOVA_PASS: {{ pillar['password']['NOVA_PASS'] }}

nova-api-sync:
  file.managed:
    - name: /root/nova_api_dbsync.sh
    - source: salt://openstack/nova/files/nova_api_dbsync.sh
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: /usr/bin/sh /root/nova_api_dbsync.sh && touch /etc/nova/nova_api_dbsync.lock
    - unless: test -f /etc/nova/nova_api_dbsync.lock

nova-dbsync:
  file.managed:
    - name: /root/novadb_sync.sh
    - source: salt://openstack/nova/files/novadb_sync.sh
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: /usr/bin/sh /root/novadb_sync.sh && touch /etc/nova/dbsync.lock
    - unless: test -f /etc/nova/dbsync.lock

nova-reg:
  file.managed:
    - name: /root/nova-reg.sh
    - source: salt://openstack/nova/files/nova-reg.sh
    - user: root
    - group: root
    - mode: 755
    - template: jinja
    - defaults:
      KEYSTONE: {{ pillar['openstack']['KEYSTONE'] }}
      NOVA: {{ pillar['openstack']['NOVA'] }}
      NOVA_PASS: {{ pillar['password']['NOVA_PASS'] }}
      NOVA_PLACEMENT_PASS: {{ pillar['password']['NOVA_PLACEMENT_PASS'] }}

  cmd.run:
    - name: /usr/bin/sh /root/nova-reg.sh && touch /etc/nova/nova-reg.lock
    - unless: test -f /etc/nova/nova-reg.lock

nova-service:
    service.running:
    - names: 
      - openstack-nova-api.service
      - openstack-nova-consoleauth.service
      - openstack-nova-scheduler.service
      - openstack-nova-conductor.service
      - openstack-nova-novncproxy.service   
    - enable: True      

