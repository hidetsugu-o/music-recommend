# RecoTune Storage
<img src="https://user-images.githubusercontent.com/74892038/105269714-d552c600-5bd7-11eb-8009-1f6cf96f988c.png"  style="border-radius: 20px; width: 50%;">

## 1. どんなアプリ？

LINEアプリでみんなが紹介したYouTube上の楽曲を、後からまとめて振り返ることができるアプリです。

- 今までどんな投稿をしてきたか、ユーザー毎に見ることができます。
- レスポンシブWebデザインに対応、スマホでも操作しやすいレイアウトです。

[Heroku](https://music-recommend-32514.herokuapp.com/)でアプリがチェックできます！<br>

#### ログインすると..<br>

![result](https://user-images.githubusercontent.com/74892038/105274381-6b8aea00-5be0-11eb-900c-f859fe6ce254.gif)

#### 各ユーザーの過去の投稿を振り返ることができます！<br>

![result](https://user-images.githubusercontent.com/74892038/105274190-0d5e0700-5be0-11eb-9581-ff16e9657a31.gif)

#### LINE BotがYouTubeリンクを登録してくれます！<br>

![result](https://user-images.githubusercontent.com/74892038/105284159-363cc700-5bf5-11eb-9995-4eff6518af42.gif)

## 2. 目次
  - [3. 利用方法](#3-利用方法)
  - [4. 開発目的（誰のどのような課題を解決しようと思ったか）](#4-開発目的誰のどのような課題を解決しようと思ったか)
  - [5. 機能一覧（どのように解決したか）](#5-機能一覧どのように解決したか)
  - [6. こだわった機能](#6-こだわった機能)
  - [7. 今後の実装予定](#7-今後の実装予定)
  - [8. データベース設計](#8-データベース設計)
  - [9. 開発環境や使用したライブラリなど](#9-開発環境や使用したライブラリなど)
  - [10. ローカルでの動作方法](#10-ローカルでの動作方法)

## 3. 利用方法
#### サイトの閲覧方法
1. [サイト](https://music-recommend-32514.herokuapp.com/)にアクセスして、`LINEアカウント`でアプリにログインするだけ！
```html
ログインすると、ユーザー毎の今までの投稿一覧を表示できます。
また、お気に入りの楽曲にイイねを押したり、自分の投稿を削除したりできます。

※ログインしなくても、トップページから最新の投稿を見ることが可能です。
```
#### 楽曲投稿方法
1. LINEアプリで`LINE Bot`を友達登録します。（スマホをお使いの場合はボタンをクリック、PCの場合はQRコードをスマホで読み取り）<br>
&nbsp;&nbsp;&nbsp;&nbsp;<a href="https://lin.ee/8KatMpp"><img src="https://scdn.line-apps.com/n/line_add_friends/btn/ja.png" alt="友だち追加" height="36" border="0"></a>
![qrコード](https://user-images.githubusercontent.com/74892038/105025851-3b810100-5a91-11eb-8e80-fefb8ad9eb10.png)

1. `LINE Bot`にYouTubeリンク付きのメッセージを送信すると、アプリに楽曲が登録されます。
```html
グループにBotを招待して、そこでメッセージを送信してもOKです。
```

## 4. 開発目的（誰のどのような課題を解決しようと思ったか）

#### 誰の？
- LINEを使って、YouTube上のオススメ楽曲を紹介しあっているグループ
#### どのような課題を？
- 過去に投稿されたオススメ楽曲を、後からまとめて振り返ることができたら楽しそう！
- 投稿一覧をユーザー毎にまとめて表示することで、みんなの投稿の傾向を知れたら面白い！！
- スマホでも見やすく！！！

## 5. 機能一覧（どのように解決したか）
### 実装ページ
- トップページ （ログインなしでもアクセス可能）
- ユーザーの一覧ページ
- 各ユーザーの詳細ページ
### 実装機能
- ユーザー管理機能（LINEアカウント連携）
  - サインアップ・ログイン・ログアウト・アカウント削除
- YouTubeリンク投稿機能
  - LINE Botを利用して、LINEアプリから投稿できる
  - 投稿フォームを利用して、アプリから投稿できる
- 投稿の一覧表示機能
  - トップページ
    - ランダムにピックアップされた投稿3件が、カルーセルで表示される
    - 最新の投稿6件が、一覧で表示される
  - ユーザーページ（横スクロールでコンテンツが表示される）
    - ユーザー本人の投稿が、新しい順で全て一覧表示される
    - ユーザーがイイねした投稿が、全て一覧表示される
    - ユーザー本人の投稿のうち、ランダムにピックアップされた3件が、一覧で表示される
- 投稿の削除機能
- 投稿へのイイね機能
  - Ajaxを用いた非同期通信
- ユーザーの一覧表示機能
- ユーザーの詳細表示機能
- レスポンシブWebデザイン
  - Bootstrapのグリッドシステムを利用

## 6. こだわった機能
#### YouTubeリンク投稿機能（LINE Bot利用）</br>

![result](https://user-images.githubusercontent.com/74892038/105284159-363cc700-5bf5-11eb-9995-4eff6518af42.gif)<br>
- こだわった点
  - YouTubeリンクのビデオIDだけを抽出してデータ登録します。
  - YouTubeの3種のURL（メイン・短縮・埋め込み）に対応。
  - 登録が完了すると、Botから登録完了のメッセージが届きます。
<br>

#### 投稿へのイイね機能（PC画面で実験）<br>

![result](https://user-images.githubusercontent.com/74892038/105017669-6403fd80-5a87-11eb-87a3-75df707e50f1.gif)<br>
- こだわった点
  - Ajax通信を用いて、非同期でイイねをつけることができます。
  - Font Awesomeのそれっぽいアイコンを利用しています。

## 7. 今後の実装予定
- 初回ログイン時に、LINE Botと友達になる選択肢が表示される機能
- 動画情報（タイトルやタグ等）の保存機能
  - YouTube Data APIをさわってみたい。
- サイトの高速化
  - YouTubeの埋め込みプレーヤーは読み込みに時間がかかるため、ページの読み込み時にはサムネイル画像が表示されるようにする。


## 8. データベース設計
- 以下のER図をご参照ください。
<br>

![ER＿MR](https://user-images.githubusercontent.com/74892038/105013289-716ab900-5a82-11eb-8372-a929eca47f20.png)

## 9. 開発環境や使用したライブラリなど
### 開発環境

- macOS: Catalina 10.15.7（19H2）
- Ruby: 2.6.5p114
- Rails: 6.0.3.4
- MySQL: 14.14
- Node.js: 14.15.0
- Yarn: 1.22.10

### 使用ライブラリ
#### Gem
- Devise : 4.7.3
- line-bot-api : 1.17.0
- omniauth-line : forked by gomo
- omniauth-rails_csrf_protection : 0.1.2
- rails-i18n : 6.0.0

omniauth-lineは、下記記事を参考に使用させて頂きました。
> https://qiita.com/MasamotoMiyata/items/ccc932e96a4f5dd6c2e1

#### JavaScriptライブラリ
- Bootstrap : 4.5.3
- jQuery : 3.5.1
- Popper.js : 1.16.1
- Font Awesome : 5.15.1

### オープンAPI
- LINE Developers
  - LINEログイン
  - Messaging API

### Paas
- Heroku

## 10. ローカルでの動作方法
- LINE Developersにて、各種API連携が必要になるため割愛します。