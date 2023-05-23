#!/bin/bash
#ekremiscan

ips=(10.1.10.37 10.1.10.40 10.1.10.35 10.1.10.36 10.1.10.38 10.1.10.39 10.1.10.25 10.1.10.17 10.1.10.23 10.1.10.22 10.1.10.33 10.1.10.32 10.1.10.20 10.1.10.28 10.1.10.21 10.1.10.26 10.1.10.27 10.1.10.24 10.1.10.44 10.1.10.46 10.1.10.43 10.1.10.45 10.1.10.41 10.1.10.42 )


for ip in "${ips[@]}"; do
        ssh -T $ip << \code 
echo -e "\033[0;37m"
ipcikti=$(ifconfig | grep addr:10 | awk -F: '{print $2}' | awk '{print $1}')
if [[ $ipcikti == '10.1.10.37' ]]; then 
echo "ED01(10.1.10.37)"
elif [[ $ipcikti == '10.1.10.40' ]]; then 
echo "ED02(10.1.10.40)"
elif [[ $ipcikti == '10.1.10.35' ]]; then 
echo "ED03(10.1.10.35)"
elif [[ $ipcikti == '10.1.10.36' ]]; then 
echo "ED04(10.1.10.36)"
elif [[ $ipcikti == '10.1.10.38' ]]; then 
echo "ED05(10.1.10.38)"
elif [[ $ipcikti == '10.1.10.39' ]]; then 
echo "ED06(10.1.10.39)"
elif [[ $ipcikti == '10.1.10.25' ]]; then 
echo "ED09(10.1.10.25)"
elif [[ $ipcikti == '10.1.10.17' ]]; then 
echo "ED10(10.1.10.17)"
elif [[ $ipcikti == '10.1.10.23' ]]; then 
echo "ED11(10.1.10.23)"
elif [[ $ipcikti == '10.1.10.22' ]]; then 
echo "ED12(10.1.10.22)"
elif [[ $ipcikti == '10.1.10.33' ]]; then 
echo "ED13(10.1.10.33)"
elif [[ $ipcikti == '10.1.10.32' ]]; then 
echo "ED14(10.1.10.32)"
elif [[ $ipcikti == '10.1.10.20' ]]; then 
echo "ED15(10.1.10.20)"
elif [[ $ipcikti == '10.1.10.28' ]]; then 
echo "ED16(10.1.10.28)"
elif [[ $ipcikti == '10.1.10.21' ]]; then 
echo "ED17(10.1.10.21)"
elif [[ $ipcikti == '10.1.10.26' ]]; then 
echo "ED18(10.1.10.26)"
elif [[ $ipcikti == '10.1.10.27' ]]; then 
echo "ED19(10.1.10.27)"
elif [[ $ipcikti == '10.1.10.24' ]]; then 
echo "ED20(10.1.10.24)"
elif [[ $ipcikti == '10.1.10.44' ]]; then 
echo "ED23(10.1.10.44)"
elif [[ $ipcikti == '10.1.10.46' ]]; then 
echo "ED24(10.1.10.46)"
elif [[ $ipcikti == '10.1.10.43' ]]; then 
echo "ED25(10.1.10.43)"
elif [[ $ipcikti == '10.1.10.45' ]]; then 
echo "ED26(10.1.10.45)"
elif [[ $ipcikti == '10.1.10.41' ]]; then 
echo "ED27(10.1.10.41)"
elif [[ $ipcikti == '10.1.10.42' ]]; then 
echo "ED28(10.1.10.42)"
fi

ssh -T scc
last=$(ls -t1 /opt/eds/log/diag/trace/* | head -n 1)
last2=$(ls -t1 /opt/eds/log/diag/trace/diag* | head -n 2 | tail -n 1)
if grep -q 'SCS state change: SHUTDOWN => HIBERNATE \| POWER LOSS => SHUTDOWN \| STARTUP => HIBERNATE' $last2 $last;

then
        grep "SCS state change: SHUTDOWN => HIBERNATE \| POWER LOSS => SHUTDOWN \| STARTUP => HIBERNATE" $last2 $last | awk -F[ '{print $2}' | awk -F] '{print $1}' | tail -n 1;
        echo -e "\033[0;32mPowercycle is done.\033[0m"
	
else
        echo -e "\033[0;31mPowercycle is not done!!\033[0m"

fi


code
done

