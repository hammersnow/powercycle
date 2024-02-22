#!/bin/bash
#ekremiscan

clear
echo ""
echo -e "\033[0;37mPOWERCYCLE KONTROL\033[0m"
date=$(date +%Y.%m.)
echo ""
read -p "Lutfen Son 3 Gun Icindeki Gormek Istediginiz Ayin Gununu Giriniz $date" tarih
ips=(10.1.10.37 10.1.10.40 10.1.10.35 10.1.10.36 10.1.10.38 10.1.10.39 10.1.10.25 10.1.10.17 10.1.10.23 10.1.10.22 10.1.10.33 10.1.10.32 10.1.10.20 10.1.10.28 10.1.10.21 10.1.10.26 10.1.10.27 10.1.10.24 10.1.10.44 10.1.10.46 10.1.10.43 10.1.10.45 10.1.10.41 10.1.10.42 )
ttarih=$tarih

echo "$ttarih" > /home/eds_cm/eko/tarih
for ip in "${ips[@]}"; do
	scp -q /home/eds_cm/eko/tarih $ip:/tmp
        ssh -T $ip << \code 
scp -q /tmp/tarih scc:/tmp
rm -f /tmp/tarih
echo -e "\033[0;37m"
edsid=$(cat /opt/eds/etc/scanner_persist.cfg | grep SCANNER | awk '{print $2}')
echo -e "\033[0;32m$edsid	 		Daily Scc startup and current working time:\033[0m" 

ssh -T scc
dat=$(date +%b)
date=$(date +%Y.%m.)
girdi=$(cat /tmp/tarih)
last=$(ls -t1 /opt/eds/log/diag/trace/* | head -n 1)
last2=$(ls -t1 /opt/eds/log/diag/trace/diag* | head -n 2 | tail -n 1)
last3=$(ls -t1 /opt/eds/log/diag/trace/diag* | head -n 3 | tail -n 1)
last4=$(ls -t1 /opt/eds/log/diag/trace/diag* | head -n 4 | tail -n 1)
last5=$(ls -t1 /opt/eds/log/diag/trace/diag* | head -n 5 | tail -n 1)
if less $last2 $last | grep "SCS state change: SHUTDOWN => HIBERNATE \| POWER LOSS => SHUTDOWN \| HIBERNATE => STARTUP \| STARTUP => HIBERNATE"| grep -q $date$girdi;

then
        echo -en "\033[0;32mPowercycle is done.\033[0m		"
	last -x reboot | tac | awk '{print $5, $6, $7, $8, $9, $10, $11}' | tail -n 1
	grep "SCS state change: SHUTDOWN => HIBERNATE \| POWER LOSS => SHUTDOWN \| STARTUP => HIBERNATE" $last2 $last | awk -F[ '{print $2}' | awk -F] '{print $1}' | grep $date$girdi | tail -n 1;
	
else
        echo -en "\033[0;31mPowercycle is not done!!\033[0m	"
	last -x reboot | tac | awk '{print $5, $6, $7, $8, $9, $10, $11}' | grep "$dat $girdi" | tail -n 1
fi
echo ""
rm -f /tmp/tarih

code
done

