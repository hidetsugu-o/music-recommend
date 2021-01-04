require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができる時' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('会員登録ページへ')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'Nickname',	with: @user.nickname
      fill_in 'Email',	with: @user.email
      fill_in 'Password',	with: @user.password
      fill_in 'Password confirmation',	with: @user.password_confirmation
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq root_path
      # 編集ページへ遷移するボタンと、ログアウトボタンが表示されていることを確認する
      expect(page).to have_content('ユーザー情報編集')
      expect(page).to have_content('ログアウト')
      # サインアップページへ遷移するボタンや、ログインページに遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('会員登録ページへ')
      expect(page).to have_no_content('ログインページへ')
    end
  end

  context 'ユーザー新規登録ができない時' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('会員登録ページへ')
      # 新規登録ページに移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'Nickname',	with: ''
      fill_in 'Email',	with: ''
      fill_in 'Password',	with: ''
      fill_in 'Password confirmation',	with: ''
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq '/users'
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインができる時' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログインページへ')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'Email',	with: @user.email
      fill_in 'Password',	with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
      # 編集ページへ遷移するボタンと、ログアウトボタンが表示されていることを確認する
      expect(page).to have_content('ユーザー情報編集')
      expect(page).to have_content('ログアウト')
      # サインアップページへ遷移するボタンや、ログインページに遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('会員登録ページへ')
      expect(page).to have_no_content('ログインページへ')
    end
  end

  context 'ログインができない時' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログインページへ')
      # ログインページへ遷移する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'Email',	with: ''
      fill_in 'Password',	with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されたことを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe 'ユーザー情報編集', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ユーザー情報編集ができる時' do
    it '正しい情報を入力すればユーザー情報編集ができてトップページに移動する' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email',	with: @user.email
      fill_in 'Password',	with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # ユーザー情報編集ページへ遷移する
      visit edit_user_registration_path
      # ユーザー情報を入力する
      fill_in 'Nickname',	with: 'nickname'
      fill_in 'Email',	with: 'sample@sample.com'
      fill_in 'Password',	with: 'password'
      fill_in 'Password confirmation',	with: 'password'
      fill_in 'Current password',	with: @user.password
      # 更新ボタンをおす
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
      # 再びユーザー情報編集ページへ遷移する
      visit edit_user_registration_path
      # フォームに編集後の情報が自動入力されていることを確認する
      expect(
        find('#user_nickname').value
      ).to eq 'nickname'
      expect(
        find('#user_email').value
      ).to eq 'sample@sample.com'
    end

    it '新しいパスワードを入力しなくてもユーザー情報編集ができてトップページに移動する' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email',	with: @user.email
      fill_in 'Password',	with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # ユーザー情報編集ページへ遷移する
      visit edit_user_registration_path
      # ユーザー情報を入力する
      fill_in 'Nickname',	with: 'nickname'
      fill_in 'Email',	with: 'sample@sample.com'
      fill_in 'Current password',	with: @user.password
      # 更新ボタンをおす
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
      # 再びユーザー情報編集ページへ遷移する
      visit edit_user_registration_path
      # フォームに編集後の情報が自動入力されていることを確認する
      expect(
        find('#user_nickname').value
      ).to eq 'nickname'
      expect(
        find('#user_email').value
      ).to eq 'sample@sample.com'
    end
  end

  context 'ログインができない時' do
    it '誤った情報ではユーザー情報編集ができずに情報編集ページへ戻ってくる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email',	with: @user.email
      fill_in 'Password',	with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # ユーザー情報編集ページへ遷移する
      visit edit_user_registration_path
      # ユーザー情報を入力する
      fill_in 'Nickname',	with: ''
      fill_in 'Email',	with: ''
      fill_in 'Current password',	with: ''
      # 更新ボタンをおす
      find('input[name="commit"]').click
      # 情報編集ページへ戻されることを確認する
      expect(current_path).to eq '/users'
      # 再びユーザー情報編集ページへ遷移する
      visit edit_user_registration_path
      # フォームに編集前の情報が自動入力されていることを確認する
      expect(
        find('#user_nickname').value
      ).to eq @user.nickname
      expect(
        find('#user_email').value
      ).to eq @user.email
    end
  end
end

RSpec.describe 'ログアウト', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログアウトができる時' do
    it 'ログインしたユーザーはログアウトができる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email',	with: @user.email
      fill_in 'Password',	with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # トップページにログアウトボタンがあることを確認する
      expect(page).to have_content('ログアウト')
      # ログアウトボタンをクリックする
      find_link('ログアウト', href: destroy_user_session_path).click
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
      # サインアップページへ遷移するボタンや、ログインページに遷移するボタンが表示されていることを確認する
      expect(page).to have_content('会員登録ページへ')
      expect(page).to have_content('ログインページへ')
    end

    it 'ログインしていないユーザーはログアウトできない' do
      # トップページへ遷移する
      visit root_path
      # ログアウトボタンがないことを確認する
      expect(page).to have_no_content('ログアウト')
    end
  end
end
