#!/bin/bash

#****************************************#
#              environment.sh
#          written by Jem Guhit
#             October 14, 2020

#         Script responsible for  
#       running python scripts of 
#           monitoring tools 
#****************************************#

Output1=/lustre/umt3/user/guhitj/Gitlab/netbasilisk/XRootD/AGLT2/Output/environment/AGLT2-CHI/
Output2=/lustre/umt3/user/guhitj/Gitlab/netbasilisk/XRootD/AGLT2/Output/environment/AGLT2/
#currentdate=`date +"%Y%m%d_%H%M"`

python AGLT2.py >> ${Output2}AGLT2_${currentdate}.csv
python AGLT2_CHI.py >> ${Output1}AGLT2-CHI_${currentdate}.csv
