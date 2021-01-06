class LinebotController < ApplicationController

  require 'line/bot'    # LINEのAPIを読み込み
  protect_from_forgery :except => [:callback]    # callbackアクションのCSRFトークン認証を無効
  before_action :validate_signature    # リクエストがLINEプラットフォームから送られたことを確認

  def callback
    body = request.body.read
    events = client.parse_events_from(body)   # HTTPリクエストのbodyを解析

    events.each { |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          response = client.get_profile(event['source']['userId'])  # 投稿者のプロフィールを取得
          contact = JSON.parse(response.body)  # JSONデータをrubyのハッシュデータに変換
          
          user_id = contact['userId']
          name = contact['displayName']

          reply = {
            type: 'text',
            text: "#{name}さん、登録が完了したぺん！\n\nhttps://music-recommend-32514.herokuapp.com/"
          }

          url = event.message['text']
          url_slice(url)

          if Post.create(video_id: url, user_id: user_id)
            client.reply_message(event['replyToken'], reply)
          end
        end
      end
    }

    head :ok
  end

  private

  def client    # クライアント情報取得用のインスタンス生成
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def validate_signature    # 認証用メソッド
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']

    unless client.validate_signature(body, signature)
      head :bad_request
    end
  end

  def url_slice(url)
    if url.include?("=")
      url.slice!("https://www.youtube.com/watch?v=")
    else
      url.slice!("https://youtu.be/")
    end
  end
end
