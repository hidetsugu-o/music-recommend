require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
  end

  describe '新規投稿機能' do
    context '新規投稿がうまくいく時' do
      it '全ての値が存在すれば登録できる' do
        expect(@post).to be_valid
      end

      it 'video_idが"_"を含んでも登録できる' do
        @post.video_id = '1yEcEo9mzr_'
        expect(@post).to be_valid
      end

      it 'video_idが"-"を含んでも登録できる' do
        @post.video_id = '1yEcEo9mzr-'
        expect(@post).to be_valid
      end
    end

    context '新規投稿がうまくいかない時' do
      it 'user_idが空だと登録できない' do
        @post.user_id = nil
        @post.valid?
        expect(@post.errors.full_messages).to include('Userを入力してください')
      end

      it 'video_idが空だと登録できない' do
        @post.video_id = nil
        @post.valid?
        expect(@post.errors.full_messages).to include('Videoを入力してください')
      end

      it 'video_idが11桁以外だと登録できない' do
        @post.video_id = 'youtube.com/watch?v=dZhmuUhcn9k'
        @post.valid?
        expect(@post.errors.full_messages).to include('Videoは登録できない値です')
      end

      it 'video_idに半角英数字と"-""_"以外を含むと登録できない' do
        @post.video_id = '1yEcEo9mzr='
        @post.valid?
        expect(@post.errors.full_messages).to include('Videoは登録できない値です')
      end
    end
  end
end
