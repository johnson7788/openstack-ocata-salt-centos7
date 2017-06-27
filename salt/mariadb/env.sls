include:
  - mariadb.install

mariadb-openstck-env:
  file.managed:
    - name: /root/openstack_env_mysql.sh
    - source: salt://mariadb/files/openstack_env_mysql.sh
    - user: root
    - group: root
    - mode: 755
    - template: jinja
    - defaults:
      MARIADB_PASS: {{ pillar['password']['MARIADB_PASS'] }}
      KEYSTONE_DBPASS: {{ pillar['password']['KEYSTONE_DBPASS'] }}
      NEUTRON_DBPASS: {{ pillar['password']['NEUTRON_DBPASS'] }}
      GLANCE_DBPASS: {{ pillar['password']['GLANCE_DBPASS'] }}
      NOVA_DBPASS: {{ pillar['password']['NOVA_DBPASS'] }}
      CINDER_DBPASS: {{ pillar['password']['CINDER_DBPASS'] }}
  cmd.run:
    - name: /usr/bin/sh /root/openstack_env_mysql.sh && touch /etc/mariadb-openstack.lock
    - unless: test -f /etc/mariadb-openstack.lock
    - require: 
      - pkg: mariadb-install
