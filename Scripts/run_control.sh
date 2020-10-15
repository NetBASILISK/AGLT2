#!/bin/bash

#****************************************#
#              run_control.sh
#          written by Jem Guhit
#             July 23, 2020

#          Runs the atlas environment 
#          setup and the benchmark 
#****************************************#
Output=/lustre/umt3/user/guhitj/Gitlab/netbasilisk/XRootD/AGLT2/Output/run_control/
Timepath=/lustre/umt3/user/guhitj/Gitlab/netbasilisk/XRootD/AGLT2/Output/timestamp/
currentdate=`date +"%Y%m%d_%H%M"`
export currentdate
#Transferring File
startTot=$(date +%s) 
echo "Starting Benchmark Program" 
for n in {1..2}; do #Number of times you want to repeat the benchmark
   echo "TEST $n"
   export n 
   #ATLAS SETUP
   ###########################################################
   echo "Reading atlas_setup.sh"
   #nohup
   bash /lustre/umt3/user/guhitj/Gitlab/netbasilisk/XRootD/AGLT2/Scripts/atlas_setup.sh 
   #bash /lustre/umt3/user/guhitj/Gitlab/netbasilisk/XRootD/atlas_setup.sh
   wait
   if [ $? -eq 0 ]; then
    echo ""
   else
    echo "FAIL. Error Code: $?"
   fi
   ###########################################################
   
   #Benchmark
   ###########################################################
   echo "Reading benchmark.sh"
   #S1 means the number of streams used for the transfer is one. You could modify. 
   bash /lustre/umt3/user/guhitj/Gitlab/netbasilisk/XRootD/AGLT2/Scripts/benchmark.sh > ${Output}${currentdate}_test${n}.log 2>&1 
   #bash /lustre/umt3/user/guhitj/Gitlab/netbasilisk/XRootD/benchmark.sh > ${Output}${currentdate}_test$n.log 2>&1
   if [ $? -eq 0 ]; then
    echo ""
   else
    echo "FAIL. Error Code: $?" 
   fi

   echo "Wait for xrootd to finish"
   wait

   if [ $? -eq 0 ]; then
    echo ""
   else
    echo "FAIL. Error Code: $?"
   fi
   ###########################################################
   
   #PARSING
   ########################################################### 
   echo "Running parse.sh"
   bash /lustre/umt3/user/guhitj/Gitlab/netbasilisk/XRootD/AGLT2/Scripts/parse.sh

   #CLEANUP
   ########################################################### 
   #echo "Reading cleanup.sh"
   #nohup bash /lustre/umt3/user/guhitj/Gitlab/netbasilisk/XRootD/cleanup.sh
   #if [ $? -eq 0 ]; then
   # echo ""
   #else
   # echo "FAIL. Error Code:$?"
   #fi
echo "------------------------------------------------------------"
done
endTot=$(date +%s)
echo -e "start=$startTot\nend=$endTot" > ${Timepath}Time.txt
secondsTot=$(echo "$endTot - $startTot" | bc)
echo 'Total Benchmark time is: ' $secondsTot 'seconds' 

#ENVIRONMENT
###########################################################
#Run Environment.sh
echo "Running environment.sh"
bash /lustre/umt3/user/guhitj/Gitlab/netbasilisk/XRootD/AGLT2/Scripts/environment.sh
wait

#CLEANUP
########################################################### 
rm ${Timepath}/Time.txt 

echo "Benchmark Program Successful"
