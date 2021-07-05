#https://meetrix.io/blog/webrtc/turnserver/long_term_cred.html
#https://github.com/meetrix/coturnDockerLongTermCredentials/blob/master/Dockerfile
#https://ourcodeworld.com/articles/read/1175/how-to-create-and-configure-your-own-stun-turn-server-with-coturn-in-ubuntu-18-04
FROM ubuntu:18.04
MAINTAINER Acaty

WORKDIR /
RUN apt-get update && apt-get install -y coturn
#RUN systemctl stop coturn
#RUN cd /etc/default
COPY ./dockerfiles/coturn /etc/default/coturn
COPY ./dockerfiles/turnserver.conf /etc/turnserver.conf

ENV TURN_PORT 3478
ENV TURN_PORT_START 10000
ENV TURN_PORT_END 20000
ENV TURN_SECRET mysecret
ENV TURN_SERVER_NAME coturn
ENV TURN_REALM store.ucssfcec.xyz



RUN turnadmin -a -u root -r store.ucssfcec.xyz -p mysecret

## sudo turnadmin -a -u brucewayne -r ourcodeworld.com -p 12345

ADD start_coturn.sh start_coturn.sh
RUN chmod +x start_coturn.sh

CMD ["./start_coturn.sh"]