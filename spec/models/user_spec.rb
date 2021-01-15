require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいく時' do
      it '全ての値が存在すれば登録できる' do
        expect(@user).to be_valid
      end

      it 'iconが存在しなくても登録できる' do
        @user.icon = nil
        expect(@user).to be_valid
      end

      it 'messageが存在しなくても登録できる' do
        @user.message = nil
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかない時' do
      it 'user_idが空だと登録できない' do
        @user.user_id = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('Userを入力してください')
      end

      it 'User_idが重複していると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, user_id: @user.user_id)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Userはすでに存在します')
      end

      it 'nameが空だと登録できない' do
        @user.name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('Nameを入力してください')
      end

      it 'passwordが空では登録できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('Passwordを入力してください')
      end
    end
  end
end
