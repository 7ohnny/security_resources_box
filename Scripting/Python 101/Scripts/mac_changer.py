#! /usr/bin/env python

import subprocess
import optparse

def get_arguments():
    parser = optparse.OptionParser()
    parser.add_option("-i","--interface",dest="interface", help="interface to change MAC address")
    parser.add_option("-m","--mac",dest="new_mac", help="new  MAC address")
    (option, arguments) =  parser.parse_args()
    if not option.interface:
        parser.error("[?] insert a valid interface")
    elif not option.new_mac:
        parser.error("[?] insert a valid Mac")
    return option


def change_mac (interface, new_mac):
    print("[+] Changing MAC Address for " + interface + " to " + new_mac )

    subprocess.call(["ifconfig",interface,"down"])
    subprocess.call(["ifconfig",interface,"hw", "ether",new_mac])
    subprocess.call(["ifconfig",interface,"up"])


option =  get_arguments()
change_mac(option.interface,option.new_mac)

