FROM ubuntu:22.04

WORKDIR /ttyd

RUN apt-get update
RUN apt-get install build-essential cmake git libjson-c-dev libwebsockets-dev -y
RUN git clone https://github.com/tsl0922/ttyd.git

RUN cd ttyd && mkdir build && cd build && cmake .. && make && make install

RUN cd /ttyd
RUN rm -rf ttyd

# Install docker
RUN apt-get install apt-transport-https ca-certificates curl software-properties-common -y
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN apt-get update
RUN apt-get install docker-ce -y

EXPOSE 7681

COPY ./entrypoint.sh /

CMD ["/entrypoint.sh"]

