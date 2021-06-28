# Find Company Name
Find company name is a python script that queries macaddress.io API, the API provides a lot of useful information regarding the organization but we are only focusing on the company name.

## Requirements 

To query the API we need the API key which can be generated for free by signing up to https://macaddress.io/ 

We also need to install requests library for making HTTP requests in Python. 

```bash
pip install requests
```

Dockerfile

```Dockerfile
FROM python:3

WORKDIR /usr/src/app

COPY findCompanyName.py .

COPY readme.txt .

RUN pip install requests

CMD ["python", "./findCompanyName.py"]
```

You can also pull the image from docker 

```bash
docker pull zoraker/get-company-name:latest
```

## Usage

```python

import requests
import re


def getCompanyName(URL, API_KEY, MAC_ADD):
	#GET request url is formated acording to the newer verion of python
    data = requests.get(f'{URL}/v1?apiKey={API_KEY}&output=json&search={MAC_ADD}')
	
    if data.status_code == 200: #validating the response
        getName = data.json()	#we get a json file which has all the vendorDetails
        return f"Company Name: {getName['vendorDetails']['companyName']}"
    elif '40' in str(data.status_code):	#checking if the API key is working
        raise Exception("Please check the API KEY")
    else:
        raise Exception("Cannot find please check the MAC Address again")
		

#Validates if the MAC is of standard (IEEE 802)		
def validateMac(MAC_ADD):
    valid = re.search('([a-zA-Z0-9]{2}[\:]){5}[a-zA-Z0-9]{2}|(([a-zA-Z0-9]{2}[\-]){5}[a-zA-Z0-9]{2})', MAC_ADD)
    if valid:
        return
    else:
		#The exception will be raised if the MAC is not of six groups of two hexadecimal digits, separated by hyphens or colons
        raise Exception("Please check the MAC Address again")
    
if __name__ == "__main__":
    try:
        URL = 'https://api.macaddress.io/'                  # This URL for creating the HTTP request                   
        API_KEY = 'at_apsFw6AVR45tkSAFEoa2BP5HoAUnX'        # API KEY is used for authentication      
        MAC_ADD = input('MAC Address: ')					# User can input any MAC to gether information
		
		validateMac(MAC_ADD)	#Validates if the MAC is of standard (IEEE 802)		

        print(getCompanyName(URL, API_KEY, MAC_ADD))	#Funcition which queries and returns the company name
		
    except Exception as e:
        print(f"Opps: {e}")
```

## Contributing
Pull requests are welcome.

Please make sure to update tests as appropriate.
