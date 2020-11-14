# [PFC.com](https://pfc-share.net/)

![スクリーンショット 2020-11-14 16 29 50](https://user-images.githubusercontent.com/54160947/99142307-38cfed00-2697-11eb-8be6-be5c9480d9ab.png)

PFC.comは筋トレやダイエットに取り組むユーザーに向けた
高タンパク質、低糖質の商品情報をシェアでき、糖質量やPFCバランスを意識したフィットネス活動をサポートするサービスです。

# URL

[https://pfc-share.net/](https://pfc-share.net/)

"ゲストユーザーでログイン"のボタンより全機能をお試しいただけます。

# 制作の背景

最近本格的に筋トレを始め、糖質量やPFCバランス(*)を考えた食事を取り入れました。
某動画共有サービスやブログなどで様々な商品や外食メニューが紹介されていますが、実際に買ったプロテインスナックなどが自分の好みでなかったことが何回かありました。

また、外食メニューやコンビニ商品で高タンパク、低糖質の商品を調べることがあり、フィットネス好きのユーザー同士でそれらの美味しい商品・メニューの情報が共有できれば、 **食事管理に対するモチベーションアップに繋がるのでは・・・** という思いでこのサービスを制作しました。

*PFCバランス：摂取カロリーのうちのタンパク質、脂質、炭水化物がどれぐらいの割合を占めるかを示した比率

# 特徴

  ### ①シェア
  
  マクロ栄養素量と糖質量をシェアすることができ、お気に入り保存、タグ付けができます。

  ### ②記録

  マイページで体重と体脂肪率が記録でき、グラフで日々の変化を確認できます。

  ### ③PFCバランス計算

  マイページでアクティブ度合い、目的別に最適なマクロ栄養素量のバランスを計算できます。

# 機能一覧

+ ユーザー登録・ログイン機能（deviseを使用）
+ 投稿機能（画像のアップロードにCarrierWaveを使用）
+ 投稿一覧・投稿詳細表示機能
+ 投稿編集・削除機能
+ ページネーション機能（kaminariを使用）
+ タグ付け機能（acts-as-taggable-onを使用）
+ 検索機能（ransackを使用）
+ いいね機能
+ お気に入り機能
+ フォロー・フォロワー機能
+ ダイレクトメッセージ機能
+ 通知機能（お気に入り登録/いいね/フォロー/DMがあった場合、ヘッダーに通知表示）
+ 通知一覧表示機能
+ Twitterシェア機能
+ お問い合わせ機能（Action Mailerを使用）
+ 管理ユーザー機能（activeadminを使用）
+ グラフ描画機能（Chart.js / amCharts.jsを使用）
+ PFCバランス計算機能
+ 体重・体脂肪率の記録機能

# 環境・使用技術

## バックエンド

+ Ruby 2.6.6
+ Rails 5.2.4.4 (RSpec / Rubocopによる動的静的テスト等も含む)

## フロントエンド

+ HTML
+ SCSS
+ JavaScript, jQuery
+ Bootstrap 4.5
  
## 開発環境

+ MySQL
+ Docker / docker-compose
+ 
## 本番環境

+ Nginx, Unicorn
+ Capistrano
+ CircleCI( CI / CD )
+ AWS( VPC / EC2 / ALB / RDS / S3 / Route53 / ACM)
+ Terraform 0.13.5 (tfstateはTerraform Cloudに保存)

## テスト

+ RSpec
+ CircleCIで自動テスト、結果をSlackに通知

## その他使用技術

+ Git / Github(Projects / Issue / プルリクエストの活用)
+ ChatWork API(問い合わせの通知)
+ 本番環境での例外発生のSlack通知

# AWSアーキテクチャ図

![pfcdotcom](https://user-images.githubusercontent.com/54160947/99142401-fd81ee00-2697-11eb-83f7-f070a56e2266.jpg)

# デモ画像

+ マイページ

+ 商品詳細画面

+ ログイン画面

+ ユーザー登録画面

+ ユーザー編集画面

# ER図

![PFC com](https://user-images.githubusercontent.com/54160947/99142403-ffe44800-2697-11eb-9262-af6def86fa4b.jpg)
