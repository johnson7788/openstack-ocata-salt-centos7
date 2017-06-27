verify_ntp:
  cmd.run:
    - name: timedatectl
    - name: systemctl status mariadb
    - name: systemctl status rabbitmq-server
    - name: systemctl status memecached

verify_keystone:
  cmd.run:
    - name: /usr/bin/sh /root/admin-openrc.sh && openstack token issue

verify_glance:
  cmd.run:
    - name: /usr/bin/sh /root/admin-openrc.sh && openstack image list

verify_nova:
  cmd.run:
    - name: /usr/bin/sh /root/admin-openrc.sh && openstack extension list --network

verify_cinder:
  cmd.run:
    - name: /usr/bin/sh /root/admin-openrc.sh && openstack volume service list

verify_namespace:
  cmd.run:
    - name: /usr/bin/sh /root/admin-openrc.sh && ip netns

