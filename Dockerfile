FROM liaohuqiu/simple-obfs:latest as obfs
# https://github.com/liaohuqiu/docker-simple-obfs


FROM shadowsocks/shadowsocks-libev:v3.2.5
# https://github.com/shadowsocks/shadowsocks-libev

LABEL maintainer="Chuan Li <root@lichuan.guru>"
LABEL version="v3.2.5-obfs"

COPY --from=obfs /usr/local/bin/obfs-server /usr/local/bin/obfs-server

ENV SERVER_PORT 443
ENV METHOD      chacha20-ietf-poly1305
ENV OBFS_HOST   www.amazon.com
ENV OBFS        tls

USER root

CMD exec ss-server \
      -s $SERVER_ADDR \
      -p $SERVER_PORT \
      -k ${PASSWORD:-$(hostname)} \
      -m $METHOD \
      -t $TIMEOUT \
      -d $DNS_ADDRS \
      --plugin obfs-server \
      --plugin-opts obfs=$OBFS;obfs-host=$OBFS_HOST \
      --reuse-port \
      --fast-open \
      -u \
      $ARGS
