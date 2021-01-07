#! /usr/bin/env python

import subprocess

interface = input("Interface: ")#"enp3s0"
new_mac =input("New Mac: ") # "00:32:A5:F2:B2:C4"

print("[+] Changing MAC Address for " + interface + " to " + new_mac )

subprocess.call(["ifconfig",interface,"down"])
subprocess.call(["ifconfig",interface,"hw", "ether",new_mac])
subprocess.call(["ifconfig",interface,"up"])

#subprocess.call("ifconfig " + interface + "down", shell=True)