httpd-install:
  pkg.installed:
    - names:
      - httpd

keystone-http:
  file.managed:
    - name: /etc/httpd/conf/httpd.conf
    - source: salt://httpd/files/httpd.conf
    - user: root
    - group: root
    - mode: 755
    - template: jinja
    - defaults:
      KEYSTONE: {{ pillar['openstack']['KEYSTONE'] }}

nova-placement-api:
  file.managed:
    - name: /etc/httpd/conf.d/00-nova-placement-api.conf
    - source: salt://httpd/files/00-nova-placement-api.conf
    - user: root
    - group: root
    - mode: 755

httpd-service:
  service.running:
    - name: httpd.service
    - enable: True
