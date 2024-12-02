FROM ubuntu:22.04
WORKDIR /app
COPY . /app
RUN apt install python3
RUN pip install -r ./requirements.txt
