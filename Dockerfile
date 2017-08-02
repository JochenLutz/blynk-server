FROM arm32v7/openjdk:8-jre
MAINTAINER Jochen Lutz <jlu@gmx.de>

ENV BLYNK_SERVER_VERSION 0.25.4
RUN mkdir /blynk
RUN curl -L https://github.com/blynkkk/blynk-server/releases/download/v${BLYNK_SERVER_VERSION}/server-${BLYNK_SERVER_VERSION}.jar > /blynk/server.jar

# Create data folder. To persist data, map a volume to /data
RUN mkdir /data

# Create configuration folder. To persist data, map a file to /config/server.properties
RUN mkdir /config && touch /config/server.properties
VOLUME ["/config", "/data/backup"]

# IP port listing:
# 8440: Hardware mqtt port
# 8441: Hardware ssl/tls port (for hardware that supports SSL/TLS sockets)
# 8442: Hardware plain tcp/ip port
# 8443: Application mutual ssl/tls port
# 8080: HTTP port
# 9443: Admin HTTPS port
EXPOSE 8080 8440 8441 8442 8443 9443

WORKDIR /data
ENTRYPOINT ["java", "-jar", "/blynk/server.jar", "-dataFolder", "/data", "-serverConfig", "/config/server.properties"]
