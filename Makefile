# ssserver config
SERVER_ADDR ?= 0.0.0.0
SERVER_PORT ?= 443
PASSWORD ?= mySecurePasswd
ENCRYPTION ?= chacha20-ietf-poly1305
TIMEOUT ?= 300

# obsf config
OBSF_HOST ?= www.bing.com

# docker run config
CONTAINER_NAME ?= ssserver
IMAGE ?= shadowsocks-libev:v3.2.5-obfs

build:
	echo building image as ${IMAGE}
	docker build -t ${IMAGE} -f ./Dockerfile .

run:
	echo "running ${IMAGE} on ${SERVER_ADDR}:${SERVER_PORT} using ${ENCRYPTION} disguised as ${OBSF_HOST}"
	docker run -d \
	  --name ${CONTAINER_NAME} \
	  -e "SERVER_ADDR=${SERVER_ADDR}" \
	  -e "SERVER_PORT=${SERVER_PORT}" \
	  -e "PASSWORD=${PASSWORD}" \
	  -e "METHOD=${ENCRYPTION}" \
	  -e "TIMEOUT=${TIMEOUT}" \
	  -e "OBSF_HOST=${OBSF_HOST}" \
	  -p "${SERVER_PORT}:${SERVER_PORT}" \
	  -p "${SERVER_PORT}:${SERVER_PORT}/udp" \
	  --restart on-failure \
	  ${IMAGE} 
