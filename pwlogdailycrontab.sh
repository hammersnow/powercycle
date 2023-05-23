#!/bin/bash
#ekremiscan

mkdir /home/eds_cm/eko/Logpw/$(date +%Y-%m-%d)
/home/eds_cm/eko/./pwlogrenksiz.sh > /home/eds_cm/eko/Logpw/$(date +%Y-%m-%d)/Powercycle-$(date +%Y-%m-%d-%s).csv
