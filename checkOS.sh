#!/bin/bash
echo ' =======Type your IP======= '
read ip;
echo ' =======Type prefix===== '
read prex;
# Check syntax
#if [ "$ip" != "" ] && [ "$sub" != "" ]  then 
#       echo " Try again :"
#       read ip;
#       echo " subnet: "
#       read sub;
while   [[ -z "$ip" ]] && [[ -z "$sub" ]]; do
        echo " Fail syntax. Try again:"
        read -p " Type new IP: " ip
        read -p " Type new subnet: " sub
        echo " Scanning $ip/$sub..............:"
done
start=$(date +%s.%N)
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
j=$(wc -l list.txt | grep -o '[[:digit:]]*')
end=$(date +%s.%N)
runtime=$(python -c "print(${end} - ${start})")
echo " Have $j host up in $ip/$sub "
echo "Runtime was $runtime sec"
##end
