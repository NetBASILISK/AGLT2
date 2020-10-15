#!/bin/bash

#****************************************#
#              main.sh
#          written by Jem Guhit
#             July 23, 2020

#    Runs run_control.sh in background
#****************************************#
Output=/lustre/umt3/user/guhitj/Gitlab/netbasilisk/XRootD/AGLT2/Output/main/
currentdate=`date +"%Y%m%d_%H%M"`
#export currentdate
bash /lustre/umt3/user/guhitj/Gitlab/netbasilisk/XRootD/AGLT2/Scripts/run_control.sh > ${Output}Benchmark${currentdate}.log 2>&1 

#Command when running perfsonar 
#bash /lustre/umt3/user/guhitj/AGLT2/netbasilisk/Scripts/run_control.sh > ${Output}Benchmark${currentdate}.log 2>&1
#echo $!

