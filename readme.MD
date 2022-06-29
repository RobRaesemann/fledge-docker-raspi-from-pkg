# Fledge Docker Image

This container runs the Fledge IoT framework on Raspbian Buster. 

You can download Fledge packages at http://dianomic.com/download-fledge/

Dianomic develops FogLAMP and Fledge
http://dianomic.com/

## Introduction to Fledge
Fledge is an IoT framework that is part of the Linux Foundation LF Edge Open Source project.

Fledge is an open sensor-to-cloud data fabric for the Internet of Things (IoT) that connects people and systems to the information they need to operate their business. It provides a scalable, secure, robust infrastructure for collecting data from sensors, processing data at the edge and transporting data to historian and other management systems. Fledge can operate over the unreliable, intermittent and low bandwidth connections often found in IoT applications.

Fledge is implemented as a collection of microservices which include:

Core services, including security, monitoring, and storage
Data transformation and alerting services
South services: Collect data from sensors and other Fledge systems
North services: Transmit data to historians and other systems
Edge data processing applications
Services can easily be developed and incorporated into the Fledge framework. The Fledge Developer Guides describe how to do this.

The Fledge Github repository:
https://github.com/fledge-iot/fledge

Fledge documentation:
https://fledge-iot.readthedocs.io/en/latest/index.html

#### Build the Docker Image
docker build --rm -f "Dockerfile" -t fledge:latest .

## To test locally
#### Create the volume for fledge data
docker create -v /usr/local/fledge/data --name fledge-data fledge:latest /bin/true

#### Run detached with autorestart
docker run --volumes-from fledge-data -d -p 8081:8081 -p 1995:1995 fledge:latest

#### Run interactively
docker run --volumes-from fledge-data -it -p 8081:8081 -p 1995:1995 fledge:latest /bin/bash

#### Attach interactively to detached session
docker exec -it fledge /bin/bash # get an interactive shell into running docker image

#### View logs
docker logs fledge

#### Test Fledge WebAPI
http://dockercontainerhost:8081/fledge/ping