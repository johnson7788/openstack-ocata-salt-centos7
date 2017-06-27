#!/bin/sh
mysql -e "create database keystone;" &&\
mysql -e "grant all on keystone.* to keystone@'localhost' identified by '{{ KEYSTONE_DBPASS }}';"&&\
mysql -e "grant all on keystone.* to keystone@'%' identified by '{ KEYSTONE_DBPASS }}';"&&\
mysql -e "create database glance;"&&\
mysql -e "grant all on glance.* to glance@'localhost' identified by '{ GLANCE_DBPASS }}';"&&\
mysql -e "grant all on glance.* to glance@'%' identified by '{ GLANCE_DBPASS }}';"&&\
mysql -e "create database nova;"&&\
mysql -e "grant all on nova.* to nova@'localhost' identified by '{ NOVA_DBPASS }}';"&&\
mysql -e "grant all on nova.* to nova@'%' identified by '{ NOVA_DBPASS }}';"&&\
mysql -e "create database nova_api;"&&\
mysql -e "grant all on nova_api.* to nova@'localhost' identified by '{ NOVA_DBPASS }}';"&&\
mysql -e "grant all on nova_api.* to nova@'%' identified by '{ NOVA_DBPASS }}';"&&\
mysql -e "create database nova_cell0;"&&\
mysql -e "grant all on nova_cell0.* to nova@'localhost' identified by '{ NOVA_DBPASS }}';"&&\
mysql -e "grant all on nova_cell0.* to nova@'%' identified by '{ NOVA_DBPASS }}';"&&\
mysql -e "create database neutron;"&&\
mysql -e "grant all on neutron.* to neutron@'localhost' identified by '{ NEUTRON_DBPASS }}';"&&\
mysql -e "grant all on neutron.* to neutron@'%' identified by '{ NEUTRON_DBPASS }}';"&&\
mysql -e "create database cinder;"&&\
mysql -e "grant all on cinder.* to cinder@'localhost' identified by '{ CINDER_DBPASS }}';"&&\
mysql -e "grant all on cinder.* to cinder@'%' identified by '{ CINDER_DBPASS }}';"&&\
mysql -e "DELETE FROM mysql.user WHERE User='';"&&\
mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%'"&&\
mysql -e "UPDATE mysql.user SET Password=PASSWORD('{{ MARIADB_PASS }}') WHERE User='root';"&&\
mysql -e "flush privileges;" 
