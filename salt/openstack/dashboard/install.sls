include:
  - openstack.env

dashboard-install:
  pkg.installed:
    - names:
      - openstack-dashboard
  file.managed:
    - name: /etc/openstack-dashboard/local_settings
    - source: salt://openstack/dashboard/files/local_settings
    - template: jinja
    - defaults:
      KEYSTONE: {{ pillar['openstack']['KEYSTONE'] }}
      MEMCACHE: {{ pillar['openstack']['MEMCACHE'] }}

dashboard-service:
  service.running:
    - names:
      - httpd
      - memcached
    - reload: True
    - enable: True
    - watch:
      - file: /etc/openstack-dashboard/local_settings
