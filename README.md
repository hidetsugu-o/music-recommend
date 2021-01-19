# RecoTune Storage
LINE上でみんながオススメしたYouTube上の楽曲を、まとめて振り返ることができるアプリです。<br>[Heroku](https://music-recommend-32514.herokuapp.com/)でアプリがチェックできます！

## どんなアプリ？

- ログインすると..<br>
![result](https://user-images.githubusercontent.com/74892038/105012068-12f10b00-5a81-11eb-9f19-9be37a1ec9cc.gif)

- みんなのオススメ楽曲を振り返ることができます！<br>
![result](https://user-images.githubusercontent.com/74892038/105011827-c60d3480-5a80-11eb-9cdd-1ed28fefa4f7.gif)

## 目次
  - [利用方法](#利用方法)
  - [目指した課題解決](#目指した課題解決)
  - [こだわりの機能](#こだわりの機能)
  - [今後の実装予定](#今後の実装予定)
  - [データベース設計](#データベース設計)
  - [開発環境や使用したライブラリなど](#開発環境や使用したライブラリなど)
  - [ローカルでの動作方法](#ローカルでの動作方法)

## 利用方法
#### サイトの閲覧
1. [サイト](https://music-recommend-32514.herokuapp.com/)にアクセスして、`LINEアカウント`でアプリにログインするだけ！
```html
ログインすると、ユーザー毎の今までの投稿一覧を表示できます。
また、お気に入りの楽曲にイイねを押したり、自分の投稿を削除したりできます。

※ログインしなくても、トップページから最新の投稿を見ることが可能です。
```
#### 楽曲投稿方法
1. `LINE Bot`を友達登録します（以下のQRコードを読み込んでください） 
   ![QRコード](https://qr-official.line.me/sid/M/783xlnxf.png)
2. `LINE Bot`にYouTubeリンク付きのメッセージを送信すると、アプリに動画が登録されます
```html
グループにBotを招待して、そこでメッセージを送信してもOKです
```

## 目指した課題解決
#### ターゲット
- LINEを使って、YouTube上のオススメ楽曲を紹介しあっているグループ
#### 課題
- 過去に紹介されたオススメ楽曲を、後からまとめて振り返ることができたら楽しそう！
- 投稿一覧をユーザー毎にまとめて表示することで、みんなの投稿の傾向を知れたら面白い！！
- スマホでも見やすく！！！
#### 課題解決のために実装した機能
- LINEメッセージを受け取り、YouTubeリンクのみをアプリに登録する機能
- ユーザー管理機能
  - LINEアカウントでのログイン機能を含む
- ユーザー毎の投稿を一覧表示する機能
  - YouTubeの埋め込みプレーヤーが表示される
- レスポンシブデザインを意識

##### 追加で実装した機能
```html
・色々な条件での一覧表示機能
  トップページ：ランダムにピックアップされた投稿、最新の投稿
  ユーザーページ：イイねした投稿、ランダムにピックアップされた投稿）
・アプリから楽曲を投稿できる機能
・投稿の削除機能
・投稿へのイイね機能
```

## こだわりの機能
- LINE Botを用いたYouTubeリンクの投稿機能</br>
![result](https://user-images.githubusercontent.com/74892038/105020573-cd394000-5a8a-11eb-8c04-01643b3b429c.gif)
  - 投稿に成功するとBotからメッセージが返って来ます
  - YouTubeリンクのビデオIDだけを抽出してデータ登録するので、他にコメント等が混ざっていても登録することができます
  - YouTubeの短縮アドレス、埋め込みアドレスにも対応しています
- 投稿へのイイね機能（PC画面で実験）<br>
![result](https://user-images.githubusercontent.com/74892038/105017669-6403fd80-5a87-11eb-87a3-75df707e50f1.gif)
  - Ajax通信を用いて非同期でイイねをつけることができます
  - アイコンは、Font Awesomeのものを利用しています


## 今後の実装予定
- 初回ログイン時に、Botと友達になる選択肢が表示される機能
- 動画情報（タイトルやタグ等）の保存機能
- サイトの高速化
  - YouTubeの埋め込みプレーヤーを、ページの読み込み時はサムネイル画像が表示されるように変更する


## データベース設計
- 以下のER図をご参照ください
![ER＿MR](https://user-images.githubusercontent.com/74892038/105013289-716ab900-5a82-11eb-8372-a929eca47f20.png)

## 開発環境や使用したライブラリなど
### 開発環境
- macOS: Catalina 10.15.7（19H2）
- Homebrew: 2.7.5
- ruby: 2.6.5p114
- Bundler: 2.1.4
- Rails: 6.0.3.4
- mysql: 14.14
- Node.js: 14.15.0
- yarn: 1.22.10
### 使用ライブラリ
#### Gem
- devise : 4.7.3
- line-bot-api : 1.17.0
- omniauth-line : forked by gomo
- omniauth-rails_csrf_protection : 0.1.2
- rails-i18n : 6.0.0

omniauth-lineは下記記事を参考に使用させて頂きました
> https://qiita.com/MasamotoMiyata/items/ccc932e96a4f5dd6c2e1

#### JavaScriptライブラリ
- bootstrap : 4.5.3
- jquery : 3.5.1
- popper.js : 1.16.1

### 使用API
#### LINE Developers
- LINEログイン
- Messaging API

## ローカルでの動作方法
- LINE Developersにて、各種API連携が必要になるため割愛します