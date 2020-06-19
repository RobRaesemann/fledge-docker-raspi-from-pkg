#
# FLEDGE 1.8.0 on Raspbian Buster
# 
FROM balenalib/raspberry-pi-debian:buster-build

# Install packages required for Fledge
RUN apt update && \
    # Install apt packages that we need to build Fledge
    #apt -y install wget rsyslog python3-dev g++ make autoconf automake libtool autotools-dev && \
    apt -y install rsyslog python3-dev sysstat && \
    # Download and decompress installation package
    wget --quiet https://github.com/fledge-iot/fledge-gui.git && \
    wget --quiet https://fledge-iot.s3.amazonaws.com/1.8.0/buster/armv7l/fledge-1.8.0_armv7l_buster.tgz && \
    tar -xzvf fledge-1.8.0_armv7l_buster.tgz && \
    # Install dependencies
    apt -y install `dpkg -I ./fledge/1.8.0/buster/armv7l/fledge-1.8.0-armv7l.deb | awk '/Depends:/{print$2}' | sed 's/,/ /g'` && \
    # Install Fledge
    dpkg-deb -R ./fledge/1.8.0/buster/armv7l/fledge-1.8.0-armv7l.deb fledge-1.8.0-armv7l && \
    cp -r fledge-1.8.0-armv7l/usr /. && \
    mv /usr/local/fledge/data.new /usr/local/fledge/data && \
    # Install plugins
    mkdir /package_temp && \
    dpkg-deb -R /fledge/1.8.0/buster/armv7l/fledge-rule-simple-expression-1.8.0-armv7l.deb /package_temp/fledge-rule-simple-expression-1.8.0-armv7l.deb/ && \
    dpkg-deb -R /fledge/1.8.0/buster/armv7l/fledge-service-notification-1.8.0-armv7l.deb /package_temp/fledge-service-notification-1.8.0-armv7l/ && \
    dpkg-deb -R /fledge/1.8.0/buster/armv7l/fledge-notify-python35-1.8.0-armv7l.deb /package_temp/fledge-notify-python35-1.8.0-armv7l/ && \
    dpkg-deb -R /fledge/1.8.0/buster/armv7l/fledge-notify-email-1.8.0-armv7l.deb /package_temp/fledge-notify-email-1.8.0-armv7l/ && \
    dpkg-deb -R /fledge/1.8.0/buster/armv7l/fledge-rule-simple-expression-1.8.0-armv7l.deb /package_temp/fledge-rule-simple-expression-1.8.0-armv7l/ && \
    dpkg-deb -R /fledge/1.8.0/buster/armv7l/fledge-rule-outofbound-1.8.0-armv7l.deb /package_temp/fledge-rule-outofbound-1.8.0-armv7l/ && \
    dpkg-deb -R /fledge/1.8.0/buster/armv7l/fledge-rule-average-1.8.0-armv7l.deb /package_temp/fledge-rule-average-1.8.0-armv7l/ && \
    dpkg-deb -R /fledge/1.8.0/buster/armv7l/fledge-filter-python35-1.8.0-armv7l.deb /package_temp/fledge-filter-python35-1.8.0-armv7l/ && \
    dpkg-deb -R /fledge/1.8.0/buster/armv7l/fledge-filter-expression-1.8.0-armv7l.deb /package_temp/fledge-filter-expression-1.8.0-armv7l/ && \
    dpkg-deb -R /fledge/1.8.0/buster/armv7l/fledge-filter-delta-1.8.0-armv7l.deb /package_temp/fledge-filter-delta-1.8.0-armv7l/ && \
    dpkg-deb -R /fledge/1.8.0/buster/armv7l/fledge-south-benchmark-1.8.0-armv7l.deb /package_temp/fledge-south-benchmark-1.8.0-armv7l/ && \
    dpkg-deb -R /fledge/1.8.0/buster/armv7l/fledge-south-dnp3-1.8.0-armv7l.deb /package_temp/fledge-south-dnp3-1.8.0-armv7l/ && \
    dpkg-deb -R /fledge/1.8.0/buster/armv7l/fledge-south-expression-1.8.0-armv7l.deb /package_temp/fledge-south-expression-1.8.0-armv7l/ && \
    dpkg-deb -R /fledge/1.8.0/buster/armv7l/fledge-south-modbustcp-1.8.0-armv7l.deb /package_temp/fledge-south-modbustcp-1.8.0-armv7l/ && \
    dpkg-deb -R /fledge/1.8.0/buster/armv7l/fledge-south-mqtt-sparkplug-1.8.0-armv7l.deb /package_temp/fledge-south-mqtt-sparkplug-1.8.0-armv7l/ && \
    dpkg-deb -R /fledge/1.8.0/buster/armv7l/fledge-south-opcua-1.8.0-armv7l.deb /package_temp/fledge-south-opcua-1.8.0-armv7l/ && \
    dpkg-deb -R /fledge/1.8.0/buster/armv7l/fledge-south-random-1.8.0-armv7l.deb /package_temp/fledge-south-random-1.8.0-armv7l/ && \
    dpkg-deb -R /fledge/1.8.0/buster/armv7l/fledge-south-randomwalk-1.8.0-armv7l.deb /package_temp/fledge-south-randomwalk-1.8.0-armv7l/ && \
    dpkg-deb -R /fledge/1.8.0/buster/armv7l/fledge-south-sinusoid-1.8.0-armv7l.deb /package_temp/fledge-south-sinusoid-1.8.0-armv7l/ && \
    dpkg-deb -R /fledge/1.8.0/buster/armv7l/fledge-south-systeminfo-1.8.0-armv7l.deb /package_temp/fledge-south-systeminfo-1.8.0-armv7l/ && \
    dpkg-deb -R /fledge/1.8.0/buster/armv7l/fledge-north-kafka-1.8.0-armv7l.deb /package_temp/fledge-north-kafka-1.8.0-armv7l/ && \
    dpkg-deb -R /fledge/1.8.0/buster/armv7l/fledge-north-http-north-1.8.0-armv7l.deb /package_temp/fledge-north-http-north-1.8.0-armv7l/ && \
    dpkg-deb -R /fledge/1.8.0/buster/armv7l/fledge-north-httpc-1.8.0-armv7l.deb /package_temp/fledge-north-httpc-1.8.0-armv7l/ && \
    # Copy plugins into place
    cp -r /package_temp/fledge-rule-simple-expression-1.8.0-armv7l.deb/usr /. && \
    cp -r /package_temp/fledge-service-notification-1.8.0-armv7l/usr /.  && \
    cp -r /package_temp/fledge-notify-python35-1.8.0-armv7l/usr  /.  && \
    cp -r /package_temp/fledge-notify-email-1.8.0-armv7l/usr /. && \
    cp -r /package_temp/fledge-rule-simple-expression-1.8.0-armv7l/usr /.  && \
    cp -r /package_temp/fledge-rule-outofbound-1.8.0-armv7l/usr /. && \
    cp -r /package_temp/fledge-rule-average-1.8.0-armv7l/usr /. && \
    cp -r /package_temp/fledge-filter-python35-1.8.0-armv7l/usr /. && \
    cp -r /package_temp/fledge-filter-expression-1.8.0-armv7l/usr /. && \
    cp -r /package_temp/fledge-filter-delta-1.8.0-armv7l/usr /. && \
    cp -r /package_temp/fledge-south-benchmark-1.8.0-armv7l/usr /. && \
    cp -r /package_temp/fledge-south-dnp3-1.8.0-armv7l/usr /. && \
    cp -r /package_temp/fledge-south-expression-1.8.0-armv7l/usr /. && \
    cp -r /package_temp/fledge-north-http-north-1.8.0-armv7l/usr /. && \
    cp -r /package_temp/fledge-north-httpc-1.8.0-armv7l/usr /. && \
    cp -r /package_temp/fledge-north-kafka-1.8.0-armv7l/usr /. && \
    cp -r /package_temp/fledge-south-modbustcp-1.8.0-armv7l/usr /. && \
    cp -r /package_temp/fledge-south-mqtt-sparkplug-1.8.0-armv7l/usr /. && \
    cp -r /package_temp/fledge-south-opcua-1.8.0-armv7l/usr /. && \
    cp -r /package_temp/fledge-south-random-1.8.0-armv7l/usr /. && \
    cp -r /package_temp/fledge-south-randomwalk-1.8.0-armv7l/usr /. && \
    cp -r /package_temp/fledge-south-sinusoid-1.8.0-armv7l/usr /. && \
    cp -r /package_temp/fledge-south-systeminfo-1.8.0-armv7l/usr /. && \
    # Clean up
    rm ./*.tgz && \
    rm -r ./fledge && \
    apt clean && \
    rm -rf package_temp && \
    rm -rf fledge-1.8.0-armv7l && \
    rm -rf /var/lib/apt/lists/* /fledge* /usr/include/boost


RUN mkdir /usr/local/fledge/python/fledge/plugins/north/kafka_north
COPY python/fledge/python/plugins/north/kafka_north/__init__.py /usr/local/fledge/python/fledge/plugins/north/kafka_north/__init__.py
COPY python/fledge/python/plugins/north/kafka_north/kafka_north.py /usr/local/fledge/python/fledge/plugins/north/kafka_north/kafka_north.py

WORKDIR /usr/local/fledge
COPY fledge.sh fledge.sh
COPY python/requirements-north-kafka.txt python/requirements-north-kafka.txt

RUN chown root:root /usr/local/fledge/fledge.sh && \
    chmod 777 /usr/local/fledge/fledge.sh && \
    ./scripts/certificates fledge 365 && \
    chown -R root:root /usr/local/fledge && \
    chown -R ${SUDO_USER}:${SUDO_USER} /usr/local/fledge/data && \
    pip3 install -r /usr/local/fledge/python/requirements.txt && \
    pip3 install -r /usr/local/fledge/python/requirements-modbustcp.txt && \
    pip3 install -r /usr/local/fledge/python/requirements-mqtt_sparkplug.txt && \
    pip3 install -r /usr/local/fledge/python/requirements-north-kafka.txt

ENV FLEDGE_ROOT=/usr/local/fledge

VOLUME /usr/local/fledge/data

# Fledge API port
EXPOSE 8081 1995 502 23

# start rsyslog, Fledge, and tail syslog
CMD ["bash","/usr/local/fledge/fledge.sh"]

LABEL maintainer="rob@raesemann.com" \
      vendor="Raesemann Enterprises, Inc." \
      vendor2="https://raesemann.com" \
      author="Rob Raesemann" \
      target="Raspian Buster" \
      version="1.8.0" \
      descriptoin="FLEDGE IIOT Framework"