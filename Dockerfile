FROM horologger/ubuntu-go:v1.16
LABEL maintainer="horologger <horologger@protonmail.com>"
#FROM golang:1.16

# Custom cache invalidation
# ARG CACHEBUST=1

RUN apt update && apt upgrade -y
RUN apt-get install -y curl lsb-release lsb-core net-tools iproute2 rsyslog

# RUN mkdir /gotty

WORKDIR /gotty

ARG TARGETPLATFORM
ARG TARGETARCH

ARG CACHEBUST=1

RUN echo "Building $TARGETPLATFORM : $CACHEBUST"
COPY . /gotty
# COPY ./ /gotty

#
RUN echo 'echo ""' >> /root/.bashrc && \
    echo 'echo ""' >> /root/.bashrc  && \
    echo "export PS1='gotty:\w\$ '" >> /root/.bashrc

RUN CGO_ENABLED=0 make

WORKDIR /root
#COPY --from=0 /gotty/gotty /usr/bin/
RUN cp /gotty/gotty /usr/bin/
# # CMD ["gotty",  "-w", "bash"]
RUN cp /gotty/docker_entrypoint.sh /usr/bin/docker_entrypoint.sh
RUN chmod a+x /usr/bin/docker_entrypoint.sh

USER 0

# Run docker_entrypoint.sh
ENTRYPOINT ["/usr/bin/docker_entrypoint.sh"]
# RUN /bin/bash