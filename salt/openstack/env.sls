openstack_ocata_yum:
  file.managed:
    - name: /etc/yum.repos.d/openstack_ocata.repo
    - source: salt://openstack/files/openstack_ocata.repo
    - user: root
    - group: root
    - mode: 644  

CentOS_Base_aliyun:
  file.managed:
    - name: /etc/yum.repos.d/CentOS-Base.repo
    - source: salt://openstack/files/CentOS-Base.repo
    - user: root
    - group: root
    - mode: 644  

epel_yum_aliyun:
  file.managed:
    - name: /etc/yum.repos.d/epel.repo
    - source: salt://openstack/files/epel.repo
    - user: root
    - group: root
    - mode: 644  

admin-openrc:
  file.managed:
    - name: /root/admin-openrc.sh
    - source: salt://openstack/files/admin-openrc.sh
    - user: root
    - group: root
    - mode: 755
    - template: jinja
    - defaults:
      KEYSTONE: {{ pillar['openstack']['KEYSTONE'] }}
      KEYSTONE_ADMIN_PASS: {{ pillar['password']['KEYSTONE_ADMIN_PASS'] }}

demo-openrc:
  file.managed:
    - name: /root/demo-openrc.sh
    - source: salt://openstack/files/demo-openrc.sh
    - user: root
    - group: root
    - mode: 755
    - template: jinja
    - defaults:
      KEYSTONE: {{ pillar['openstack']['KEYSTONE'] }}
      KEYSTONE_DEMO_PASS: {{ pillar['password']['KEYSTONE_DEMO_PASS'] }}

yum-priority-install:
  pkg.installed:
    - names:
      - yum-plugin-priorities