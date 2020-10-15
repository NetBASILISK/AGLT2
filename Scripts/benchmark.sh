#!/bin/bash

#****************************************#
#              benchmark.sh
#          written by Jem Guhit
#             July 23, 2020

#         Script responsible for  
#       transferring specific set of 
#       files and timing how long it 
#       takes. Produces log files
#****************************************#

#Directory of files 
Source=root://dcgftp.usatlas.bnl.gov:1094//pnfs/usatlas.bnl.gov/MCDISK/hiro/test/

#Directory of transferred files 
Dest=root://xrootd.aglt2.org:1094//pnfs/aglt2.org/atlasscratchdisk/NetBASILISK/XrootD/

#Directory of log files 
Output=/lustre/umt3/user/guhitj/Gitlab/netbasilisk/XRootD/AGLT2/Output/benchmark/
#currentdate=`date +"%Y%m%d_%H%M"`

#Creates the $Dest directory. 
uberftp -mkdir gsiftp://dcdum01.aglt2.org/pnfs/aglt2.org/atlasscratchdisk/NetBASILISK/XrootD

echo "Begin Loop"
mkdir -p ${Output}${currentdate}_${n}
if [ $? -eq 0 ]; then
    echo ""
else
    echo "FAIL. Error Code: $?"
fi
startTot=$(date +%s)
#paste TestFiles_medium.txt Checksumvals_medium.txt | while read line1 line2; do
paste /lustre/umt3/user/guhitj/Gitlab/netbasilisk/XRootD/AGLT2/Scripts/txtfiles/TestFiles_short.txt /lustre/umt3/user/guhitj/Gitlab/netbasilisk/XRootD/AGLT2/Scripts/txtfiles/Checksumvals_short.txt | while read line1 line2; do
  echo "Reading $line1"
  echo "which xrdcp: "
  which xrdcp 
  start=$(date +%s)
  xrdcp --verbose --debug 3 --force --streams 4 --retry 0 --cksum adler32:$line2 $Source$line1 $Dest$line1 > ${Output}${currentdate}_${n}/debug${line1}.log 2>&1 
  if [ $? -eq 0 ]; then
    echo ""
  else
    echo "FAIL. Error Code: $?"
  fi
  
  end=$(date +%s)
  seconds=$(echo "$end - $start" | bc)
  echo $seconds 'seconds'
echo "------------------------------------------------------" 
done
endTot=$(date +%s)
secondsTot=$(echo "$endTot - $startTot" | bc)
echo 'Total transfer time is: ' $secondsTot 'seconds'
#Bandwidth=$( echo "scale=5 ; 99430.4/$secondsTot"| bc) #Good files total size
#Bandwidth=$( echo "scale=5 ; 219885.3914/$secondsTot"| bc) old values
#Bandwidth=$( echo "scale=5 ; 236032/$secondsTot"| bc) #Total size for both good and bad file
#echo "Bandwidth:" $Bandwidth "MB/s"
#FileSize= 219885.3914
#Bandwidth=$( echo "scale=5 ; $var1/$var2"| bc)
#echo "Bandwidth:" $Bandwidth "MB/s"
echo "Done!"
echo "------------------------------------------------------"

