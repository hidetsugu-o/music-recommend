require 'rails_helper'

RSpec.describe 'LINE連携で新規登録（ログイン）、ログアウト', type: :system do
  context 'LINE連携で新規登録（ログイン）、ログアウトができる時' do
    before do
      # LINE認証後のレスポンスのモックを生成
      Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
      Rails.application.env_config['omniauth.auth'] = line_mock
      # トップページに移動する
      visit root_path
    end

    it 'LINE認証が成功すれば、ユーザー新規登録ができてトップページに移動する' do
      # LINE認証が成功するとユーザー新規登録が行われることを確認する
      expect do
        click_link 'LINEでログイン'
      end.to change { User.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq root_path
      # 記事投稿ボタンが表示されていることを確認する
      expect(page).to have_content('さあ！投稿しよう')
    end

    it '既に登録されたユーザーがLINE認証を行っても新規登録はされず、ログイン処理のみが行われる' do
      # 新規登録する
      click_link 'LINEでログイン'
      # ログアウトする
      find('svg[class="svg-inline--fa fa-bars fa-w-14"]').click
      click_link 'ログアウト'
      # トップページへ遷移したことを確認する
      expect(current_path).to eq root_path
      # ライン認証を行うと新規登録はされず、ログイン処理のみが行われることを確認する
      expect do
        click_link 'LINEでログイン'
      end.not_to change { User.count }
      # トップページへ遷移したことを確認する
      expect(current_path).to eq root_path
      # 記事投稿ボタンが表示されていることを確認する
      expect(page).to have_content('さあ！投稿しよう')
    end

    it 'ログインしたユーザーはログアウトができる' do
      # ログインする
      click_link 'LINEでログイン'
      # ログアウトする
      find('svg[class="svg-inline--fa fa-bars fa-w-14"]').click
      click_link 'ログアウト'
      # トップページへ遷移したことを確認する
      expect(current_path).to eq root_path
      # ログインボタンが表示されていることを確認する
      expect(page).to have_content('LINEでログイン')
    end
  end
end

RSpec.describe 'ユーザー一覧表示', type: :system do
  context 'ユーザーの一覧表示がされる時' do
    before do
      # 複数ユーザー登録をする
      @users = FactoryBot.create_list(:user, 2)
      # トップページに移動する
      visit root_path
    end

    it 'ログインしていないままユーザー一覧ページに遷移しても、ユーザー情報が一覧表示されている' do
      # ユーザーの一覧ページに遷移する
      find('svg[class="svg-inline--fa fa-bars fa-w-14"]').click
      click_link 'ユーザーの一覧'
      expect(current_path).to eq users_path
      # 各ユーザーのname、icon、messageが表示されていることを確認する
      @users.each do |user|
        expect(page).to have_content(user.name)
        expect(page).to have_selector("img[src='#{user.icon}']")
        expect(page).to have_content(user.message)
      end
    end

    it 'ログインしているユーザーがユーザー一覧ページに遷移すると、ユーザー情報が一覧表示されている' do
      # ログインする
      user = FactoryBot.create(:user)
      login_as user, scope: :user
      # ユーザーの一覧ページに遷移する
      find('svg[class="svg-inline--fa fa-bars fa-w-14"]').click
      click_link 'ユーザーの一覧'
      expect(current_path).to eq users_path
      # 各ユーザーのname、icon、messageが表示されていることを確認する
      @users.each do |user|
        expect(page).to have_content(user.name)
        expect(page).to have_selector("img[src='#{user.icon}']")
        expect(page).to have_content(user.message)
      end
    end
  end
end

RSpec.describe 'ユーザー詳細表示', type: :system do
  context 'ユーザーの詳細表示がされる時' do
    before do
      # ユーザー登録する
      @user = FactoryBot.create(:user)
      # ユーザーが投稿する
      @post = FactoryBot.create(:post, user_id: @user.user_id)
    end

    it 'ログインしていないままユーザー詳細ページに遷移しても、ユーザーの詳細が表示されている' do
      # ユーザーの詳細ページに遷移する ※本当はリンクから飛ぶことも確認する
      visit user_path(@user)
      # 詳細ページの要素が表示されていることを確認する
      expect(page).to have_content("#{@user.name}さんの投稿からピックアップ")
      # 投稿一覧には削除ボタンが表示されていないことを確認する
      expect(page).to have_no_content('削除')
    end

    it 'ログイン中のユーザーがユーザー詳細ページに遷移しても、ユーザーの詳細が表示されている' do
      # ログインする
      user = FactoryBot.create(:user)
      login_as user, scope: :user
      # ユーザーの詳細ページに遷移する ※本当はリンクから飛ぶことも確認する
      visit user_path(@user)
      # 詳細ページの要素が表示されていることを確認する
      expect(page).to have_content("#{@user.name}さんの投稿からピックアップ")
      # 一覧には削除ボタンが表示されていないことを確認する
      expect(page).to have_no_content('削除')
    end

    it 'ログイン中のユーザーが本人のユーザー詳細ページに遷移すると、通常の表示に加えて投稿の削除ボタンが表示される' do
      # 本人としてログインする
      user = @user
      login_as user, scope: :user
      # ユーザーの詳細ページに遷移する ※本当はリンクから飛ぶことも確認する
      visit user_path(@user)
      # 詳細ページの要素が表示されていることを確認する
      expect(page).to have_content("#{@user.name}さんの投稿からピックアップ")
      # 一覧には削除ボタンが表示されていることを確認する
      expect(page).to have_content('削除')
    end
  end
end
