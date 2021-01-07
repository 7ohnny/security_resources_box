#ASCII

# script for automated tasks in Android applications

# Imports the monkeyrunner modules used by this program
from com.android.monkeyrunner import MonkeyRunner, MonkeyDevice

# Connects to the current device, returning a MonkeyDevice object
device = MonkeyRunner.waitForConnection()
# Installs the Android package. Notice that this method returns a boolean, so
# you can test to see if the installation worked.
#device.installPackage(‘example.apk’)

#set variables array #agency+countId 
accounts = []
for line in open('/folder/file.txt','r'):
	accounts.append(line.rstrip())

# sets a variable with the package’s internal name
package = 'com.example'

# sets a variable with the name of an Activity in the PACKAGE
activity = 'com.example.activity.Login'
# sets the name of the component to start
runComponent = package + '/' + activity

# Runs the component
#device.startActivity(component=runComponent)
device.startActivity(component=runComponent)

#loop access each account in array	
for agency in accounts:
	# Presses the Menu button
	#device.press('KEYCODE_MENU', MonkeyDevice.DOWN_AND_UP)
	# Wait for few seconds
	MonkeyRunner.sleep(6)
	#Access another account
	#input field mobile - Motorola
	device.touch(200,785,'DOWN_AND_UP')
	#input number of agency and account
	device.type(agency)
	#sleep
	MonkeyRunner.sleep(1)
	#Access Button mobile - Motorola
	device.touch(550,1101,'DOWN_AND_UP')
	#sleep
	MonkeyRunner.sleep(10)
	#Back Button app
	device.touch(286,1502,'DOWN_AND_UP')
	MonkeyRunner.sleep(2)
	#Back Button app
	device.touch(286,1502,'DOWN_AND_UP')
	MonkeyRunner.sleep(2)
	#Back Button Android
	device.press('KEYCODE_BACK',MonkeyDevice.DOWN_AND_UP)
	MonkeyRunner.sleep(1)
	device.press('KEYCODE_BACK',MonkeyDevice.DOWN_AND_UP)
	device.startActivity(component=runComponent)
	#Button Back
	#device.press('KEYCODE_BACK',MonkeyDevice.DOWN_AND_UP)
	#MonkeyRunner.sleep(4)


#input test#
#device.touch(700,670,'DOWN_AND_UP')
#MonkeyRunner.sleep(1)
#device.press('KEYCODE_DEL', MonkeyDevice.DOWN_AND_UP)
#MonkeyRunner.sleep(1)
#device.type('435344')

#MonkeyRunner.sleep(2)
#Touch the new status button
#device.touch(500,1015,'DOWN_AND_UP')

#Wait for few seconds
#MonkeyRunner.sleep(2)

# Takes a screenshot
#result = device.takeSnapshot()
# Wait for few seconds
#MonkeyRunner.sleep(2)

# Writes the screenshot to a file
#result.writeToFile(‘Test/status_update.png’,’png’)