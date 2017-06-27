include:
  - openstack.env

neutron-install:
  pkg.installed:
    - names:
       - openstack-neutron
       - openstack-neutron-linuxbridge
       - ebtables
       - ipset
  file.managed:
    - name: /etc/neutron/neutron.conf
    - source: salt://openstack/neutron/files/neutron.conf
    - user: root
    - group: neutron
    - mode: 640
    - template: jinja
    - defaults:
      KEYSTONE: {{ pillar['openstack']['KEYSTONE'] }}
      MEMCACHE: {{ pillar['openstack']['MEMCACHE'] }}
      MARIADB: {{ pillar['openstack']['MARIADB'] }}
      RABBITMQ: {{ pillar['openstack']['RABBITMQ'] }}
      CONTROLLER: {{ pillar['openstack']['CONTROLLER'] }}
      NEUTRON_PASS: {{ pillar['password']['NEUTRON_PASS'] }}
      NEUTRON_DBPASS: {{ pillar['password']['NEUTRON_DBPASS'] }}
      RABBIT_PASS: {{ pillar['password']['RABBIT_PASS'] }}
      NOVA_PASS: {{ pillar['password']['NOVA_PASS'] }}
ml2_conf.ini:
  file.managed:
    - name: /etc/neutron/plugins/ml2/ml2_conf.ini
    - source: salt://openstack/neutron/files/ml2_conf.ini
  cmd.run:
    - name: ln -s /etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugin.ini
    - unless: test -f /etc/neutron/plugin.ini

linuxbridge_agent.ini:
  file.managed:
    - name: /etc/neutron/plugins/ml2/linuxbridge_agent.ini
    - source: salt://openstack/neutron/files/linuxbridge_agent.ini

neutron-service:
    service.running:
    - names: 
      - neutron-linuxbridge-agent.service
    - enable: True      

