FROM python:3

WORKDIR /usr/src/app

COPY findCompanyName.py .

COPY readme.txt .

RUN pip install requests

CMD ["python", "./findCompanyName.py"]
