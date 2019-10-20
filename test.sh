#!/bin/sh
set -x

readonly cacert_path="./.generated/root.crt"
readonly server_ip="127.0.0.1"
readonly port=443

curl --cacert $cacert_path -sS https://example.com:$port/123 --resolve example.com:$port:$server_ip

curl --cacert $cacert_path -sS https://hoge.example.com:$port/456 --resolve hoge.example.com:$port:$server_ip

curl --cacert $cacert_path -sS https://$server_ip:$port/789
