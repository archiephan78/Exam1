#!/bin/bash
echo ' =======Type your IP( type theo dang x.x.x.0 neu khong thi khong chinh xac lam... )======= ' 
read ipadd;
echo ' =======Type prefix====== '
read sub;
echo " Scanning $ipadd/$sub...............: "
# Check syntax
while 	[[ -z "$ipadd" ]] && [[ -z "$sub" ]]; do
	echo " Fail syntax. Try again:"
	read -p " Type new IP: " ipadd
	read -p " Type new prefix: " sub
	echo " Scanning $ipadd/$sub..............:"
done
start=$(date +%s.%N)
### list ip in prefix. List ra text
for ip in $ipadd ;do
	net=$(echo $ip | cut -d '/' -f 1);
	i1=$(echo $net | cut -d '.' -f4);
	i2=$(echo $net | cut -d '.' -f3);
	i3=$(echo $net | cut -d '.' -f2);
	i4=$(echo $net | cut -d '.' -f1);
	len=$(echo "2^(32 - $sub)"|bc);
	for i in `seq $len`;do
		echo "$i4.$i3.$i2.$i1";
		i1=$(echo "$i1+1"|bc);
		if [ $i1 -eq 256 ]; then
			i1=0;
			i2=$(echo "$i2+1"|bc);
			if [ $i2 -eq 256 ]; then
				i2=0;
				i3=$(echo "$i3+1"|bc);
				if [ $i3 -eq 256 ]; then
				i3=0;
				i4=$(echo "$i4+1"|bc);
				fi
			fi
		fi
	done
done > test.txt
## list host alive
for n in $(cat test.txt); do
	ping -c 1 -W 1 $n > /dev/null 2>&1
       	if [ $? -eq 0 ]; then
		echo $n
	fi
done > test2.txt	
## detect OS
#cat list.txt << EOF 
for i in $(cat test2.txt);
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
		echo " $i unknow OS"															
	else
		echo " $i unknow OS"															
	fi
	fi
fi
done
j=$(wc -l test2.txt | grep -o '[[:digit:]]*')
end=$(date +%s.%N)  
runtime=$(python -c "print(${end} - ${start})")
echo " Have $j host up in $ip/$sub "
echo "Runtime was $runtime sec"
