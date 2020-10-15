#!/usr/bin/env python

import requests
import os
hosts = ['umfs06','umfs14', 'umfs20', 'umfs23', 'umfs26', 'umfs09', 'umfs16', 'umfs21', 'umfs24', 'umfs27', 'umfs02', 'umfs11', 'umfs19', 'umfs22', 'umfs25', 'umfs28' ]
servers = ['CPU_load', 'CPU_utilization', 'Disk_IO_SUMMARY', 'Memory']
url = 'http://um-omd.aglt2.org/atlas/pnp4nagios/xport/json'

variables = {}

path = "/lustre/umt3/user/guhitj/AGLT2/netbasilisk/Output/timestamp"

with open(os.path.join(path,"Time.txt")) as f:
    for line in f:
        name, value = line.split("=")
        variables[name] = float(value)

start = variables["start"]
startf = int(start)
end = variables["end"]
endf = int(end)

for i in servers:
	#print('{}'.format(i))
     	for j in hosts:
	#	print('{}'.format(j))
		querystring = {"start":"{}".format(startf),"end":"{}".format(endf),"host":"{}".format(j), "srv":"{}".format(i)}
		#querystring = {"start":"1602068400","end":"1602070200","host":"{}".format(j), "srv":"{}".format(i)} 
		#print(querystring)

		payload = ""
		headers = {
		    'cookie': "pnp4nagios=81b90oupt9qsjvd1h09unjivn1",
		    'authorization': "Basic b21kYWRtaW46U05ldXRyaW5vOTk="
		    }

		response = requests.request("GET", url, data=payload, headers=headers, params=querystring)

		print(response.text)
