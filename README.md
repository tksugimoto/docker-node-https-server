# https server
自己署名Root証明書・Server証明書を生成してhttpsサーバーを作成

## 使い方
1. [docker, docker-compose をインストール](https://docs.docker.com/install/#supported-platforms)
1. 設定
    1. 設定ファイルを作成: `.env.example` を `.env` にコピー
        ```sh
        cp .env.example .env
        ```
    1. 設定ファイル `.env` を必要に応じて編集
        - ※ 同名の環境変数が定義されていると、 `.env` での定義より環境変数が優先される
            - ただし、Windowsの場合、小文字が含まれる環境変数は `.env` が優先される可能性がある
        - ※ Docker Machine を使っている場合は、`HTTPS_SERVER_BIND_IP` には `127.0.0.0/8` のIPではなく、 `docker-machine ip` で得られるIPを設定する必要がある
            ```
            $ docker-machine ip
            192.168.99.100
            ```

1. サーバーを起動
    ```sh
    docker-compose up -d
    ```
