#!/bin/bash

DEVICE=device_wifi
IP=10.42.0
INPUT=device
OUTPUT=device_wifi

sudo nmcli networking wifi off
sudo rfkill unblock wlan
sudo ifconfig $DEVICE down
sudo ifconfig $DEVICE $IP.1 netmask 255.255.255.0 broadcast $IP.255 up
sleep 1

sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"

sudo iptables -t nat -A POSTROUTING -o $INPUT -j MASQUERADE
sudo iptables -A FORWARD -i $INPUT -o $OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i $OUTPUT -o $INPUT -j ACCEPT
sudo service hostapd stop
sudo hostapd /etc/hostapd/hostapd.conf 