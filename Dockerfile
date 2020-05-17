##Download base image Ubuntu
FROM ubuntu:bionic

MAINTAINER Lorenzo Comotti

##Define the ENV variable
ENV TERRARIA_VERSION=1.4.0.2
ENV TERRARIA_CONF /opt/terraria/Linux/

##Update Software repository and install required pakages
RUN apt update && apt -y upgrade && apt -y install unzip wget

##Download Terraria Server
RUN cd /opt && wget https://terraria.org/server/terraria-server-1402.zip -O /opt/terraria-server-1402.zip

##Extract the archive
RUN mkdir -p /opt/terraria && unzip -o /opt/terraria-server-1402.zip -d /opt/terraria && mv -vn /opt/terraria/1402/* /opt/terraria/ && rm -R -f /opt/1402 && rm /opt/terraria-server-1402.zip

##Copy start script
COPY server-start.sh ${TERRARIA_CONF}
RUN chmod +x ${TERRARIA_CONF}server-start.sh 

WORKDIR "/opt/terraria/Linux"

ENTRYPOINT [ "/opt/terraria/Linux/server-start.sh" ]

EXPOSE 7777
