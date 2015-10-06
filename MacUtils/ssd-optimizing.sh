#!/bin/sh
if [ $UID -ne 0 ]; then
	echo "Hey $USER please run this with user root!!!"
	exit 1
fi
clear
echo -e "Optimizing your Mac !!!"
system_profiler SPHardwareDataType

LAPTOP=$(system_profiler SPHardwareDataType | grep  MacBook | wc -l)

if [ $LAPTOP -ne 0 ]; then
	Model_Name=$(system_profiler SPHardwareDataType | grep "Model Name:")
	echo "Laptop Detected - $Model_Name"
	echo "Turning off local Time Machine snapshots"
	tmutil disablelocal
	echo "Turning off hibernation"
	pmset -a hibernatemode 0
	echo "Removing sleep image file"
	rm /var/vm/sleepimage
	echo "Laptop Tunning DONE!!!"
fi

echo  "Do you want to turn off the sudden motion sensor? [no HDD only]: (y/n) "
read SMS

if [ "$SMS" == "y" ]; then
	echo "Turning off sudden motion sensor"
	pmset -a sms 0
fi



