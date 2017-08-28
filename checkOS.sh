#!/bin/bash
echo ' =======Type your IP======= '
read ip;
echo ' =======Type prefix===== '
read prex;
# Check syntax
[ "$ip" != ' ' ] && [ "$prex" != ' ' ] && echo " Scanning $ip/$prex.......^... :" 
#list ip
nmap -sn "$ip/$prex" | cut -d " " -f 5 | sed '/latency)./d' | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" > list.txt
## detect OS
#cat list.txt << EOF 
for i in $(cat list.txt);
do
	nc -zvw 10 $i 22 > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "$i using linux"
	else
		nc -zvw 10 $i 3389 > /dev/null 2>&1
		if [ $? -eq 0 ]; then
			echo "$i using Windows"
		else
		nc -zvw 10 $i 22 3389 > /dev/null 2>&1
		if [ $? -eq 0 ]; then
			echo " $i unknow OS"
		else
			echo " $i unknow OS"
		fi
	fi
fi
done
