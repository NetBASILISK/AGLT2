import os
import time

import requests

tags = {}

attributes = {
    "summary": {

    },
    "server stats": {
        'cpu load max': {
            'umfs01': 3,
            'umfs02': 3,
        },
        'cpu load min':  {
            'umfs01': 3,
            'umfs02': 3,
        },
    },
    'paths': {
        "rbin": {
            'ports': {
                "0": {
                    "utilization": 1,
                    "bits": 1,
                    "bits per second": 1,
                },
                "1": {
                    "utilization": 1,
                    "bits": 1,
                    "bits per second": 1,
                },
            },
        },
        "chicaglt2": {
            'ports': {
                "0": {
                    "input": 1,
                    "output": 1,
                },
                "1": {
                    "input": 1,
                    "output": 1,
                },
                "2": {
                    "input": 1,
                    "output": 1,
                },
                "3": {
                    "input": 1,
                    "output": 1,
                },
                "4": {
                    "input": 1,
                    "output": 1,
                },
                "5": {
                    "input": 1,
                    "output": 1,
                },
            },
        },
    },
}

data = [
    {
        "tags": tags,
        "events": [
            {
                "timestamp": time.time() * 1000,
                "attributes": attributes,
            }
        ]
    }
]

resp = requests.post(
    f'{os.getenv("HUMIO_URL")}/api/v1/ingest/humio-structured',
    headers={
        'Authorization': f'Bearer {os.getenv("INGEST_TOKEN")}'
    },
    json=data,
)

resp.raise_for_status()
print(resp)
