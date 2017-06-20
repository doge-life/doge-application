FROM openjdk:alpine

ADD ./doge-webapp/build/libs /application

WORKDIR /application

ADD VERSION .

CMD ["java", "-jar", "doge-webapp.jar"]
