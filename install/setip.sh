#!/bin/bash

nmcli con mod enp0s8 \
ipv4.method manual \
ipv4.addr 172.16.0.200/24 \
ipv4.gateway 172.16.0.1 \
connection.autoconnect yes \
ipv4.never-default no
