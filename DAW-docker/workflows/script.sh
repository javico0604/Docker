#!/bin/bash
cd /opt/javier/java

sudo docker container stop javier_java
sudo docker container rm javier_java

sudo rm -rf /opt/javier/java/Docker

git clone https://github.com/javico0604/Docker.git

sudo docker container run \
	-v /opt/javier/java/Docker/DAW-docker:/usr/src/mymaven \
	-w /usr/src/mymaven \
	maven:3.9.6-eclipse-temurin-17 \
	mvn clean package

sudo rm -rf /opt/javier/java/target
sudo mkdir /opt/javier/java/target
sudo mv /opt/javier/java/Docker/DAW-docker/target/DAW-docker-0.0.1-SNAPSHOT.jar /opt/javier/java/target/app.jar
sudo rm -rf /opt/javier/java/Docker

sudo docker container run \
	-dit \
	--restart always \
	-v /opt/javier/java/target:/tmp \
   	-p 9001:8080 \
   	--name javier_java \
   	--hostname javier_java \
	eclipse-temurin:17.0.10_7-jdk \
	java -jar /tmp/app.jar
