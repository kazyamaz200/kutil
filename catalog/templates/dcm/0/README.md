## DNS & CA Management Stack Template

#### 構成

External DNS、証明書認証局などが含まれます。

- Cert Register
  - Certificate Authority
- Service Register
  - Consul

#### 説明

##### Cert Register

Rancher Loadbalancerで利用可能な証明書を発行し、Rancher Serverに登録します。ドメインを追加して証明書を更新する場合は`authority`の`SSL_DNS`に追記し、`register-cert`の`CERT_NAME`を変更してアップグレードします。

自己証明書なので、ブラウザ等で警告を出さないためには、作成したルート証明書を信頼する証明書としてPCに登録する必要があります。

##### Service Register

`consul`をExternalDNSとして利用し、各ドメインを登録します。PC等から利用する場合は、該当ホストのIPをDNSに追加してください。ドメインを追加したい場合は、`register-service`の`SERVICES`に追記してアップグレードします。

