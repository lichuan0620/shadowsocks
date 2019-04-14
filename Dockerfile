FROM liaohuqiu/simple-obfs:latest as obfs
# https://github.com/liaohuqiu/docker-simple-obfs


FROM shadowsocks/shadowsocks-libev:v3.2.5
# https://github.com/shadowsocks/shadowsocks-libev

LABEL maintainer="Chuan Li <root@lichuan.guru>"
LAEBL version="v3.2.5-obfs"

COPY --from=obfs /usr/local/bin/obfs-server /usr/local/bin/obfs-server

ENV SERVER_PORT 443
ENV METHOD      chacha20-ietf-poly1305
ENV OBFS_PATH   /usr/local/bin/obfs-server
ENV OBFS_HOST   www.amazon.com
ENV OBFS        tls

CMD exec ss-server \
      -s $SERVER_ADDR \
      -p $SERVER_PORT \
      -k ${PASSWORD:-$(hostname)} \
      -m $METHOD \
      -t $TIMEOUT \
      -d $DNS_ADDRS \
      --plugin ${OBFS_PATH} \
      --plugin_opts obfs=${OBFS};obfs-host=${OBFS_HOST} \
      -u \
      $ARGS
