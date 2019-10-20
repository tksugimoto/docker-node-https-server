#!/bin/sh
set -x

readonly cacert_path="./.generated/root.crt"
readonly server_ip=$(docker-machine ip)

curl --cacert $cacert_path -sS https://example.com/123 --resolve example.com:443:$server_ip

curl --cacert $cacert_path -sS https://hoge.example.com/456 --resolve hoge.example.com:443:$server_ip

curl --cacert $cacert_path -sS https://$server_ip/789
