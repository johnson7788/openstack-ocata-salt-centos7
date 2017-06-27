include:
  - openstack.env

cinder-install:
  pkg.installed:
    - names:
       - python-oslo-policy  
       - openstack-cinder
       - targetcli
       - lvm2
  file.managed:
    - name: /etc/cinder/cinder.conf
    - source: salt://openstack/cinder/files/cinder.conf
    - user: root
    - group: cinder
    - mode: 640
    - template: jinja
    - defaults:
      GLANCE: {{ pillar['openstack']['GLANCE'] }}
      MARIADB: {{ pillar['openstack']['MARIADB'] }}
      KEYSTONE: {{ pillar['openstack']['KEYSTONE'] }}
      RABBITMQ: {{ pillar['openstack']['RABBITMQ'] }}
      CONTROLLER: {{ pillar['openstack']['CONTROLLER'] }}
      MEMCACHE: {{ pillar['openstack']['MEMCACHE'] }}
      RABBIT_PASS: {{ pillar['password']['RABBIT_PASS'] }}
      CINDER_DBPASS: {{ pillar['password']['CINDER_DBPASS'] }}
      CINDER_PASS: {{ pillar['password']['CINDER_PASS'] }}

cinder-service:
  service.running:
    - names:
      - openstack-cinder-volume
      - target
      - lvm2-lvmetad.service
    - enable: True
    - watch:
      - file: /etc/cinder/cinder.conf
