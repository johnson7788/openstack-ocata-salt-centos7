include:
  - openstack.env

glance-install:
  pkg.installed:
    - names:
       - openstack-glance
       - python-glance
       - python2-glanceclient

glance-api:
  file.managed:
    - name: /etc/glance/glance-api.conf
    - source: salt://openstack/glance/files/glance-api.conf
    - user: root
    - group: glance
    - mode: 640
    - template: jinja
    - defaults:
      MARIADB: {{ pillar['openstack']['MARIADB'] }}
      KEYSTONE: {{ pillar['openstack']['KEYSTONE'] }}
      MEMCACHE: {{ pillar['openstack']['MEMCACHE'] }}
      GLANCE_DBPASS: {{ pillar['password']['GLANCE_DBPASS'] }}
      GLANCE_PASS: {{ pillar['password']['GLANCE_PASS'] }}

glance-registry:
    file.managed:
    - name: /etc/glance/glance-registry.conf
    - source: salt://openstack/glance/files/glance-registry.conf
    - user: root
    - group: glance
    - mode: 640
    - template: jinja
    - defaults:
      MARIADB: {{ pillar['openstack']['MARIADB'] }}
      KEYSTONE: {{ pillar['openstack']['KEYSTONE'] }}
      MEMCACHE: {{ pillar['openstack']['MEMCACHE'] }}
      GLANCE_DBPASS: {{ pillar['password']['GLANCE_DBPASS'] }}
      GLANCE_PASS: {{ pillar['password']['GLANCE_PASS'] }}

glance-dbsync:
  file.managed:
    - name: /root/glancedb_sync.sh
    - source: salt://openstack/glance/files/glancedb_sync.sh
    - user: root
    - group: root
    - mode: 755
    - template: jinja
    - defaults:
  cmd.run:
    - name: /usr/bin/sh /root/glancedb_sync.sh && touch /etc/glance/dbsync.lock
    - unless: test -f /etc/glance/dbsync.lock

glance-reg:
  file.managed:
    - name: /root/glance-reg.sh
    - source: salt://openstack/glance/files/glance-reg.sh
    - user: root
    - group: root
    - mode: 755
    - template: jinja
    - defaults:
      GLANCE: {{ pillar['openstack']['GLANCE'] }}
      GLANCE_PASS: {{ pillar['password']['GLANCE_PASS'] }}

  cmd.run:
    - name: /usr/bin/sh /root/glance-reg.sh && touch /etc/glance/glance-reg.lock
    - unless: test -f /etc/glance/glance-reg.lock

glance-api-service:
  service.running:
    - name: openstack-glance-api
    - enable: True
    - watch:
      - file: glance-api

glance-registry-service:  
  service.running:
    - name: openstack-glance-registry
    - enable: True
    - watch:
      - file: glance-registry

