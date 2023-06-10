# terraf0rm-snowflake
## プロジェクト名の決定
- web-service

## AWSリソールの命名規則の決定
- {sysstemName}-{environment}-{resource}
- {sysstemName}-{environment}-{resource}-0x 複数ある場合（Webサーバ等）

## terafformのバージョン
- tfenvで管理する
  - .terraform-versionでバージョンを指定

## ロール
- terraformの実行に必要なロールの作成
  - 初回に1度実行する