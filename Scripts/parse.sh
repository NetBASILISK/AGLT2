#!/bin/bash

#****************************************#
#              parse.sh
#          written by Jem Guhit
#             August 18, 2020
#
#         Collects important 
#       information from benchmark.sh 
#****************************************#

Output=/lustre/umt3/user/guhitj/Gitlab/netbasilisk/XRootD/AGLT2/Output/parse/
#Directory of run_control_new
PATH_RC=/lustre/umt3/user/guhitj/Gitlab/netbasilisk/XRootD/AGLT2/Output/run_control/
#Directory of benchmark_new
PATH_BENCHMARK=/lustre/umt3/user/guhitj/Gitlab/netbasilisk/XRootD/AGLT2/Output/benchmark/

cd $PATH_RC
#Important variables 
Bandwidth=$(grep -n "Bandwidth:" ${PATH_RC}${currentdate}_test${n}.log)
Ttime=$(grep -n "Total transfer time " ${PATH_RC}${currentdate}_test${n}.log)
ErrCt=$(grep -c "Error" ${PATH_RC}${currentdate}_test${n}.log)
Err=$(grep -n "Error" ${PATH_RC}${currentdate}_test${n}.log)
Time=$(grep "seconds" ${PATH_RC}${currentdate}_test${n}.log | head -n -1 | cut -d' ' -f 1 )
echo ${currentdate}_test$n "  "  $Bandwidth "  "  $Ttime "  " $ErrCt "  "  >> ${Output}parseRC_${currentdate}.txt
(echo "${currentdate}_test$n "; echo $Err ; echo " ") >> ${Output}parseRC_err_${currentdate}.txt
echo -e "$Time" >> ${Output}/Time_${currentdate}_test${n}.txt

wait 

paste /lustre/umt3/user/guhitj/Gitlab/netbasilisk/XRootD/AGLT2/Scripts/txtfiles/Size.txt ${Output}Time_${currentdate}_test${n}.txt | while read size time; do 
FileBW=$(echo "scale=5; $size/$time" | bc)
echo $FileBW >> ${Output}Speed_${currentdate}_test${n}.txt
done

wait

cd $PATH_BENCHMARK
grep -rsi "Run: " >> ${Output}XrootDErr_${currentdate}.txt
#grep -rsi -m1 "Socket error: Connection reset by peer" >> ${Output}xrdcp_socket.txt 
