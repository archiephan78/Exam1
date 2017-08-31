#!/bin/bash
echo ' =======Type your IP======= '
read ip;
<<<<<<< HEAD
echo ' =======Type subnet======== '
read sub;
echo " Scanning $ip/$sub......."
=======
echo ' =======Type subnet===== '
read sub;
>>>>>>> 221301ab824c0377f3151dd85ea73695c36ef071
# Check syntax
#if [ "$ip" != "" ] && [ "$sub" != "" ]  then 
#       echo " Try again :"
#       read ip;
#       echo " subnet: "
#       read sub;
while   [[ -z "$ip" ]] && [[ -z "$sub" ]]; do
<<<<<<< HEAD
	echo " Fail syntax. Try again:"
	read -p " Type new IP: " ip
	read -p " Type new subnet: " sub
	echo " Scanning $ip/$sub.............."
=======
        echo " Fail syntax. Try again:"
        read -p " Type new IP: " ip
        read -p " Type new subnet: " sub
        echo " Scanning $ip/$sub..............:"
>>>>>>> 221301ab824c0377f3151dd85ea73695c36ef071
done
start=$(date +%s.%N)
#list ip
nmap -sn "$ip/$sub" | cut -d " " -f 5 | sed '/latency)./d' | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" > list.txt
## detect OS
#cat list.txt << EOF 
for i in $(cat list.txt);
do
	nc -zvw 3 $i 22 > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "$i using linux"
	else
	nc -zvw 3 $i 3389 > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "$i using Windows"
	else
	nc -zvw 3 $i 22 3389 > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "$i is unknow OS"
	else
		echo "$i is unknow OS"
	fi
fi
fi
done
j=$(wc -l list.txt | grep -o '[[:digit:]]*')
end=$(date +%s.%N)
runtime=$(python -c "print(${end} - ${start})")
<<<<<<< HEAD
	echo " Have $j host up in $ip/$sub "
	echo "Runtime was $runtime sec"
##end

=======
echo " Have $j host up in $ip/$sub "
echo "Runtime was $runtime sec"
##end
>>>>>>> 221301ab824c0377f3151dd85ea73695c36ef071
