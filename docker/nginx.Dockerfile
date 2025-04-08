FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y nginx=1.18.* && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

CMD ["nginx", "-g", "daemon off;"]
