include:
  - openstack.env
  - httpd.install
  - memcached.install

keystone-install:
  pkg.installed:
    - names:
       - openstack-keystone
       - python-openstackclient
       - mod_wsgi
  file.managed:
    - name: /etc/keystone/keystone.conf
    - source: salt://openstack/keystone/files/keystone.conf
    - user: root
    - group: keystone
    - mode: 640
    - template: jinja
    - defaults:
      MARIADB: {{ pillar['openstack']['MARIADB'] }}
      KEYSTONE_DBPASS: {{ pillar['password']['KEYSTONE_DBPASS'] }}
keystone-dbsync:
  file.managed:
    - name: /root/keystonedb_sync.sh
    - source: salt://openstack/keystone/files/keystonedb_sync.sh
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: /usr/bin/sh /root/keystonedb_sync.sh && touch /etc/keystone/dbsync.lock
    - unless: test -f /etc/keystone/dbsync.lock

wsgi-keystone:
  file.managed:
    - name: /etc/httpd/conf.d/wsgi-keystone.conf
    - source: salt://openstack/keystone/files/wsgi-keystone.conf
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: systemctl restart httpd
    - watch:
      - file: /etc/httpd/conf.d/wsgi-keystone.conf

keystone-reg:
  file.managed:
    - name: /root/keystone-reg.sh
    - source: salt://openstack/keystone/files/keystone-reg.sh
    - user: root
    - group: root
    - mode: 755
    - template: jinja
    - defaults:
      KEYSTONE: {{ pillar['openstack']['KEYSTONE'] }}
      KEYSTONE_ADMIN_PASS: {{ pillar['password']['KEYSTONE_ADMIN_PASS'] }}
      KEYSTONE_DEMO_PASS: {{ pillar['password']['KEYSTONE_DEMO_PASS'] }}
  cmd.run:
    - name: /usr/bin/sh /root/keystone-reg.sh && touch /etc/keystone/reg.lock
    - unless: test -f /etc/keystone/reg.lock
