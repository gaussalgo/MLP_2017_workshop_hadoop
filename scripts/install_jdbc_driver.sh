#!/bin/bash

# needs to have exported eth1_hosts variable

yum -y install wget
wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.41.tar.gz

for server in $eth1_hosts; do
  scp -C mysql-connector-java-5.1.41.tar.gz root@${server}:~/
  ssh root@${server} 'tar -xvzf mysql-connector-java-5.1.41.tar.gz; mkdir -p /usr/share/java/; cp mysql-connector-java-5.1.41/mysql-connector-java-5.1.41-bin.jar /usr/share/java/mysql-connector-java.jar'
done
