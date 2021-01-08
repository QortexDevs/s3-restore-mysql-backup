FROM debian:buster-slim

LABEL maintainer='Qortex <it@qortex.ru>'

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y \
    awscli \
    mariadb-client 

ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.7.3/wait /wait
RUN ["chmod", "+x", "/wait"]

COPY entrypoint.sh /entrypoint.sh
RUN ["chmod", "+x", "/entrypoint.sh"]

ENTRYPOINT [ "/entrypoint.sh" ]
