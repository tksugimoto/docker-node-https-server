#!/bin/sh
set -ex

: Environment variable "SERVER_DOMAINS": ${SERVER_DOMAINS:?is not defined}



readonly root_key_dir=./.generated

readonly root_private_key_path=${root_key_dir}/root-key.pem
readonly root_cert_path=${root_key_dir}/root.crt
readonly root_serial_path=${root_key_dir}/root.srl

# ROOT: 秘密鍵の生成
openssl genrsa \
    -out $root_private_key_path \

# ROOT: CSR, 証明書の生成
openssl req \
    -new \
    -key $root_private_key_path \
    -subj "/CN=${ROOT_CERT_COMMON_NAME:-Private CA}" \
    -x509 \
    -days ${ROOT_CERT_LIFETIME_DAYS:-30} \
    -out $root_cert_path \


export server_key_dir=./.keys
mkdir -p $server_key_dir

readonly server_private_key_path=${server_key_dir}/server-key.pem
readonly server_cert_path=${server_key_dir}/server.crt
readonly server_san_path=${server_key_dir}/server_san.txt


echo "subjectAltName = $(printf -- "DNS:%s, " ${SERVER_DOMAINS}) IP: ${HTTPS_SERVER_BIND_IP}" > ${server_san_path}

# Server: 秘密鍵の生成
openssl genrsa \
    -out ${server_private_key_path} \

# Server: CSR, 証明書の生成
openssl req \
    -new \
    -key ${server_private_key_path} \
    -subj "/O=Private HTTPS SERVER" \
| openssl x509 \
    -req \
    -CAkey ${root_private_key_path} \
    -CA ${root_cert_path} \
    -CAserial ${root_serial_path} \
    -CAcreateserial \
    -extfile ${server_san_path} \
    -out ${server_cert_path} \

# start https server
node index.js
