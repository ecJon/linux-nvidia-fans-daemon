#!/bin/sh

DISPLAY=:0 nvidia-settings -a "[gpu:0]/GPUFanControlState=1"

control_unit=`echo "scale=3;100 / 70"|bc`

while [ 1 ];do
	sleep 1s
	temp=`nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader`
	tmpf=`echo "$temp * $control_unit"|bc`
	tmp=`printf "%1.0f" $tmpf`
	echo $tmp
	DISPLAY=:0 nvidia-settings -a [fan:0]/GPUTargetFanSpeed=$tmp
done
