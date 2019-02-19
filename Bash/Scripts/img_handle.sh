#!/bin/bash
# Srcipt bash to help out the process of brute force when there is a captcha in the request 

convert CaptchaExample.png -fuzz 30% -fill 'rgb(255,255,255)' -opaque 'rgb(192,192,192)' foo3.png

convert   -fuzz 0% -fill 'rgb(255,0,0)' -opaque 'rgb(192,192,192)' foo.png

# the gocr tool is used to capture de result of a captcha among other things
#gocr -p ./ocrdb/ -m 386 -a 100 foo3.png 
