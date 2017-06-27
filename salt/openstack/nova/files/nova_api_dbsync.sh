#!/bin/sh
su -s /bin/sh -c "nova-manage api_db sync" nova &&\
su -s /bin/sh -c "nova-manage cell_v2 map_cell0" nova &&\
su -s /bin/sh -c "nova-manage cell_v2 create_cell --name=cell1 --verbose" nova