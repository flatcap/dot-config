#!/bin/bash

systemctl stop libvirtd

PID=$(pgrep -n dnsmasq)
PID=$((PID-1))
kill $PID

> virbr0.status 
systemctl restart dnsmasq-hosts.path
systemctl start libvirtd

