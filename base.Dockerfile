FROM ubuntu:22.04
WORKDIR /app
COPY . /app
RUN apt update
RUN apt upgrade
RUN apt install python3 python3-pip -y
RUN pip install -r ./requirements.txt
