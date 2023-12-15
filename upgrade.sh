#!/bin/bash

sudo wget https://github.com/netbox-community/netbox/archive/refs/tags/v3.6.5.tar.gz

sudo tar -xzf v3.6.5.tar.gz -C /opt

systemctl stop netbox netbox-rq

sudo ln -sfn /opt/netbox-3.6.5/ /opt/netbox

cp /opt/netbox-3.1.4/local_requirements.txt /opt/netbox/
cp /opt/netbox-3.1.4/netbox/netbox/configuration.py /opt/netbox/netbox/netbox/
cp -pr /opt/netbox-3.1.4/netbox/media/ /opt/netbox/netbox/
cp -r /opt/netbox-3.1.4/netbox/reports/ /opt/netbox/netbox/
cp -r /opt/netbox-3.1.4/netbox/scripts/ /opt/netbox/netbox/

cd /opt/netbox/

sudo ./upgrade.sh

sudo ln -s /opt/netbox/contrib/netbox-housekeeping.sh /etc/cron.daily/netbox-housekeeping

systemctl restart netbox netbox-rq

cp /opt/netbox-3.1.4/gunicorn.py /opt/netbox/

systemctl restart netbox netbox-rq
systemctl status netbox netbox-rq
