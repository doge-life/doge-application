FROM openjdk:alpine

ADD ./doge-webapp/build/libs /application

WORKDIR /application

ADD VERSION .

CMD ["./doge-webapp.jar"]
