FROM debian:bookworm

RUN apt update &&\
    apt-get install -y spawn-fcgi fcgiwrap mosquitto-clients jq

EXPOSE 9001

CMD ["/usr/bin/spawn-fcgi", "-n", "-a", "0.0.0.0","-p","9001","--","/usr/sbin/fcgiwrap"]
