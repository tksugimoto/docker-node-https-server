#!/bin/sh
set -ex

export SERVER_DOMAINS="example.com example.net *.example.com"

export HTTPS_SERVER_BIND_IP="127.0.0.1"
export HTTPS_SERVER_BIND_PORT=443

./https-server/start.sh
