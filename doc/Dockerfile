FROM openjdk:19-jdk-slim

LABEL org.opencontainers.image.created="12 January 2022"	
LABEL org.opencontainers.image.authors="adku44"	
LABEL org.opencontainers.image.revision="1.0"
		
ARG JMETER_VERSION=5.4
		
RUN apt-get clean && \
    apt-get update && \
    apt-get -qy install \
    wget \
    unzip \
    telnet \
    iputils-ping 

RUN mkdir /jmeter && \
    cd /jmeter/ && \
    wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz && \
    tar -xzf apache-jmeter-$JMETER_VERSION.tgz && \
    rm apache-jmeter-$JMETER_VERSION.tgz

RUN cd /jmeter/apache-jmeter-$JMETER_VERSION/ && wget -q -O /tmp/JMeterPlugins-Standard-1.4.0.zip https://jmeter-plugins.org/downloads/file/JMeterPlugins-Standard-1.4.0.zip && \
    unzip -n /tmp/JMeterPlugins-Standard-1.4.0.zip && rm /tmp/JMeterPlugins-Standard-1.4.0.zip

RUN cd /jmeter/apache-jmeter-$JMETER_VERSION/ && wget -q -O /tmp/bzm-parallel-0.7.zip https://jmeter-plugins.org/files/packages/bzm-parallel-0.7.zip && \
    unzip -n /tmp/bzm-parallel-0.7.zip && rm /tmp/bzm-parallel-0.7.zip


ENV JMETER_HOME /jmeter/apache-jmeter-$JMETER_VERSION/
		
ENV PATH $JMETER_HOME/bin:$PATH
