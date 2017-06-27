include:
  - openstack.env

cinder-install:
  pkg.installed:
    - names:
       - openstack-cinder
       - python2-cinderclient
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

cinder-dbsync:
  file.managed:
    - name: /root/cinderdb_sync.sh
    - source: salt://openstack/cinder/files/cinderdb_sync.sh
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: /usr/bin/sh /root/cinderdb_sync.sh && touch /etc/cinder/dbsync.lock
    - unless: test -f /etc/cinder/dbsync.lock

cinder-reg:
  file.managed:
    - name: /root/cinder-reg.sh
    - source: salt://openstack/cinder/files/cinder-reg.sh
    - user: root
    - group: root
    - mode: 755
    - template: jinja
    - defaults:
      CINDER: {{ pillar['openstack']['CINDER'] }}
      CINDER_PASS: {{ pillar['password']['CINDER_PASS'] }}
  cmd.run:
    - name: /usr/bin/sh /root/cinder-reg.sh && touch /etc/cinder/cinder-reg.lock
    - unless: test -f /etc/cinder/cinder-reg.lock

cinder-service:
  service.running:
    - names:
      - openstack-cinder-api
      - openstack-cinder-scheduler
    - enable: True
    - watch:
      - file: /etc/cinder/cinder.conf
