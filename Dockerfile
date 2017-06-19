FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
    openjdk-8-jdk

ADD ./doge-webapp/build/libs /application

WORKDIR /application

ADD VERSION .

CMD ["./doge-webapp.jar"]
