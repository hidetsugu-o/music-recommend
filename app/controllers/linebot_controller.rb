class LinebotController < ApplicationController
  require 'line/bot'    # LINEのAPIを読み込み
  protect_from_forgery except: [:callback] # callbackアクションのCSRFトークン認証を無効
  before_action :validate_signature # リクエストがLINEプラットフォームから送られたことを確認

  def callback
    body = request.body.read
    events = client.parse_events_from(body) # HTTPリクエストのbodyを解析

    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          response = client.get_profile(event['source']['userId']) # 投稿者のプロフィールを取得
          contact = JSON.parse(response.body) # JSONデータをrubyのハッシュデータに変換

          user_id = contact['userId']
          name = contact['displayName']
          str = event.message['text']

          post = Post.new(video_id: str, user_id: user_id)

          if post.include_youtube?
            post.save
            reply = {
              type: 'text',
              text: "#{name}さん、登録が完了したぺん！\n\nhttps://music-recommend-32514.herokuapp.com/"
            }
          end

          client.reply_message(event['replyToken'], reply)
        end
      end
    end

    head :ok
  end

  private

  # クライアント情報取得用のインスタンス生成
  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end
  end

  # 認証用メソッド
  def validate_signature
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']

    head :bad_request unless client.validate_signature(body, signature)
  end
end
