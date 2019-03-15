#!/bin/bash

lanic='network inteface'			
lanip='network'

IP='ip example'

# Flush
/sbin/iptables -F
/sbin/iptables -t nat -F
/sbin/iptables -t mangle -F

/sbin/iptables -X
/sbin/iptables -t nat -X
/sbin/iptables -t mangle -X

# Policy
/sbin/iptables -P INPUT DROP
/sbin/iptables -P FORWARD DROP
/sbin/iptables -P OUTPUT ACCEPT

# Loopback
/sbin/iptables -A INPUT -i lo -j ACCEPT
/sbin/iptables -A OUTPUT -o lo -j ACCEPT

# --- #

# State
/sbin/iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Example network mobile
/sbin/iptables -A INPUT -s 10.42.0.11 -p tcp --dport 8080 -j ACCEPT

# Allows SMTP access
#/sbin/iptables -A INPUT -p tcp --dport 25 -j ACCEPT

# Allows pop and pops connections
#/sbin/iptables -A INPUT -p tcp --dport 110 -j ACCEPT
#/sbin/iptables -A INPUT -p tcp --dport 995 -j ACCEPT

# Allows imap and imaps connections
#/sbin/iptables -A INPUT -p tcp --dport 143 -j ACCEPT
#/sbin/iptables -A INPUT -p tcp --dport 993 -j ACCEPT

#Reject
#/sbin/iptables -A FORWARD -i enp4s0 -j REJECT

# Enable Forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward

#Mask ip Nat
#/sbin/iptables -t nat -A POSTROUTING -s $IP -o enp4s0 -j SNAT --to $IP1

# t
#/sbin/iptables -A INPUT -p icmp --icmp-type echo-request -m limit --limit 1/s -j ACCEPT

# mod limit
#echo 0 > /proc/sys/net/ipv4/tcp_syncookies

#/sbin/iptables -N syn-flood

#/sbin/iptables -A INPUT -i enp4s0 -p tcp --syn -j syn-flood

#/sbin/iptables -A syn-flood -m limit --limit 1/s --limit-burst 4 -j RETURN

#/sbin/iptables -A syn-flood -j DROP

#for i in /proc/sys/net/ipv4/conf/*/rp_filter;do
#	echo 1 >$i
#done

#/sbin/iptables -A FORWARD -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s -j ACCEPT

# mac

#icmp

#rules
## open port ssh tcp port 22 ##
#/sbin/iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
#/sbin/iptables -A INPUT -s $IP/24 -m state --state NEW -p tcp --dport 22 -j ACCEPT
 