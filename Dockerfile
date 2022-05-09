# FROM docker.io/ubuntu:18.04

# RUN apt-get update -y && apt-get install -y python-pip python3.7-dev
FROM python:3.7-alpine

COPY ./requirement.txt /app/requirement.txt

WORKDIR /app

RUN pip install -r requirement.txt

COPY . /app

ENTRYPOINT [ "python" ]

CMD [ "app.py" ]

