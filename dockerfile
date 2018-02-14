# Docker File for a simple Postgres 9.5 Database
# docker build -q -t connect2id:6.16 .
# docker run -it -p 2201:22 -p 5433:5432 connect2id:6.16
# docker run -d -p 8090:8080 --name connectid connect2id:6.16
# Includes: SSH Server and Connect2ID 6.16
#

# ------------Build-------------------
# cd "/Users/luigi/Documents/Technical/Project/Docker/dock connect2id/"
# docker build -t connect2id:6.16 .

FROM centos:7

MAINTAINER Luigi Manzo <luigi@konghq.com>

# ------------Directives-------------------
#


# ------------Environment-------------------


#ENV PGDATA=/usr/pgsql-9.5/data

# OS Setup
#Configure /etc/sysconfig/network-scripts/ifcfg-eth0
RUN yum -y install /sbin/service which nano openssh-server openssh-server-sysvinit openssh-clients net-tools curl wget systemd-sysv initscripts tcpdump sysstat unzip

# Java9.0.4 Installation
# Connect2id Installation
RUN wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.rpm && \
  rpm -ihv jdk-8u161-linux-x64.rpm && \
  rm jdk-8u161-linux-x64.rpm && \
	wget https://connect2id.com/assets/products/server/download/6.16/Connect2id-server.zip && \
  unzip Connect2id-server.zip && \
  rm Connect2id-server.zip

#Final Checks
COPY entrypoint.sh /entrypoint.sh
EXPOSE 8080

CMD ["/connect2id-server-6.16/tomcat/bin/catalina.sh","run"]
