# This UBUNTU Container is only for testing how namenodes containers work to prepare our Mesos Environment. 

FROM ubuntu:14.04

MAINTAINER Rogier Dikkes <r.dikkes @ gmail.com>

USER root

# We set the timezone
ENV TZ=Europe/Amsterdam
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# We set the environment for the project name, this will be declared in the marathon json file.
ENV GROUP management

# Install basic tools
RUN apt-get update -y && apt-get install --no-install-recommends -y -q wget curl sudo supervisor ansible monit uuid-runtime git ntp

# Create all directories we need
RUN mkdir -p /opt/bin/
RUN mkdir -p /var/log/hadoop/
RUN mkdir -p /hdfs-data/
RUN mkdir -p /hdfs-nn/
RUN mkdir -p /etc/apt/sources.list.d/

# Get the Java packages
RUN curl -LO 'http://download.oracle.com/otn-pub/java/jdk/7u67-b01/jdk-7u67-linux-x64.tar.gz' -H 'Cookie: oraclelicense=accepmt-securebackup-cookie'
RUN tar xfz jdk-7u67-linux-x64.tar.gz -C /opt/bin/
RUN rm -f jdk-7u67-linux-x64.tar.gz

# Synch the time
ntpd -qg
service ntp start

# Set the environment for JAVA
ENV JAVA_HOME /opt/bin/jdk1.7.0_67
ENV PATH $PATH:$JAVA_HOME/bin

# Install Hadoop Namenode
RUN wget 'http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh/cloudera.list' -O /etc/apt/sources.list.d/cloudera.list
RUN wget http://archive.cloudera.com/cdh5/ubuntu/lucid/amd64/cdh/archive.key -O archive.key
RUN wget http://archive.cloudera.com/cdh5/ubuntu/lucid/amd64/cdh/archive.key -O archive.key
ADD cloudera.pref /etc/apt/preferences.d/cloudera.pref
RUN apt-get update -y && apt-get install -y hadoop-hdfs-namenode --force-yes

# Add configuration for HDFS, next version: Ansible pulls private bitbucket configs till we have our own Build setup going
# THIS IS FOR TESTING ONLY
ADD hadoop-env.sh /etc/hadoop/conf/hadoop-env.sh
ADD core-site.xml.tmp /etc/hadoop/conf/core-site.xml.tmp
ADD hdfs-site.xml /etc/hadoop/conf/hdfs-site.xml

# Configure supervisord
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Start hadoop
ADD pre-start-hadoop.sh /opt/bin/pre-start-hadoop.sh
RUN chmod a+x /opt/bin/pre-start-hadoop.sh
ENTRYPOINT /opt/bin/pre-start-hadoop.sh && /usr/bin/supervisord

EXPOSE 50020 50070 50090 50010 50075 8031 8032 8033 8040 8042 49707 8088 8030 8020
