FROM ubuntu:latest as builder
ARG V2RAY_VER=v4.19.1
RUN apt-get update
RUN apt-get install curl unzip -y
RUN curl -L -o v2ray.zip https://github.com/v2ray/v2ray-core/releases/download/${V2RAY_VER}/v2ray-linux-64.zip
RUN unzip v2ray.zip -d v2ray
RUN chmod +x v2ray/v2ray v2ray/v2ctl

FROM alpine:latest
LABEL maintainer "Wo Lisi <wolisi@tuta.io>"

ARG TZ="Asia/Shanghai"

COPY --from=builder v2ray/geoip.dat v2ray/geosite.dat v2ray/v2ray v2ray/v2ctl /usr/bin/v2ray/
COPY config.json /etc/v2ray/config.json

RUN set -ex \
# && apk --no-cache upgrade --update \
 && apk --no-cache add ca-certificates tzdata \
 && mkdir /var/log/v2ray/ \
 && cp /usr/share/zoneinfo/${TZ} /etc/localtime \
 && echo ${TZ} > /etc/timezone \
 && apk del tzdata

WORKDIR /usr/bin/v2ray

EXPOSE 1080

CMD ["./v2ray", "-config=/etc/v2ray/config.json"]
