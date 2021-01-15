require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @like = FactoryBot.build(:like)
  end

  describe 'イイね新規登録' do
    context '新規登録がうまくいく時' do
      it '全ての値が存在すれば登録できる' do
        expect(@like).to be_valid
      end

      it '特定のpost_idに複数のuser_idで登録できる' do
        @like.save
        another_user_like = FactoryBot.build(:like, post_id: @like.post_id)
        expect(another_user_like).to be_valid
      end
    end

    context '新規登録がうまくいかない時' do
      it 'user_idが存在しないと登録できない' do
        @like.user_id = nil
        @like.valid?
        expect(@like.errors.full_messages).to include('Userを入力してください')
      end

      it 'post_idが存在しないと登録できない' do
        @like.post_id = nil
        @like.valid?
        expect(@like.errors.full_messages).to include('Postを入力してください')
      end

      it 'user_idとpost_idが同一のデータが既に保存されている場合、登録できない' do
        @like.save
        same_like = FactoryBot.build(:like, user_id: @like.user_id, post_id: @like.post_id)
        same_like.valid?
        expect(same_like.errors.full_messages).to include('Postはすでに存在します')
      end
    end
  end
end
