require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content("新規登録")
      # 新規登録ページへ移動する
      visit new_user_registration_path 
      # ユーザー情報を入力する
      fill_in "nickname", with: @user.nickname
      fill_in "full_name", with: @user.full_name
      fill_in "full_name_kana", with: @user.full_name_kana
      fill_in "email", with: @user.email
      fill_in "password", with: @user.password
      fill_in "password-confirmation", with: @user.password_confirmation
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count}.by(1)
      #トップページへ遷移したことを確認する
      expect(current_path).to eq root_path
      #ログアウトボタンが表示されているかを確認する
      expect(page).to have_content("ログアウト")
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
    expect(page).to have_no_content("新規登録")
    expect(page).to have_no_content("ログイン")
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content("新規登録")
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'nickname', with: ""
      fill_in 'email', with: ""
      fill_in 'password', with: ""
      fill_in 'password-confirmation', with: ""
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find("input[name='commit']").click
      }.to change{User.count}.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq "/users"
    end
  end
end

  RSpec.describe 'ログイン', type: :system do
    before do
      @user = FactoryBot.create(:user)
    end
    context 'ログインができるとき' do
      it '保存されているユーザーの情報と合致すればログインができる' do
        # トップページに移動する
        visit root_path
        # トップページにログインページへ遷移するボタンがあることを確認する
        expect(page).to have_content("ログイン")
        # ログインページへ遷移する
        visit new_user_session_path
        # 正しいユーザー情報を入力する
        fill_in "email", with: @user.email
        fill_in "password", with: @user.password
        # ログインボタンを押す
        find('input[name="commit"]').click
        # トップページへ遷移することを確認する
        visit root_path
        #ユーザー名とログアウトボタン・マイページ・プロフィールが表示されることを確認する
        expect(page).to have_content(@user.nickname)
        expect(page).to have_content("ログアウト")
        expect(page).to have_content("マイページ")
        # 新規登録ページとログインページへ遷移するボタンが表示されていないことを確認する
        expect(page).to have_no_content("新規登録")
        expect(page).to have_no_content("ログイン")
      end
    end
    context 'ログインができないとき' do
      it '保存されているユーザーの情報と合致しないとログインができない' do
        # トップページに移動する
      visit root_path
        # トップページにログインページへ遷移するボタンがあることを確認する
        expect(page).to have_content("ログイン")
        # ログインページへ遷移する
        visit new_user_session_path
        # ユーザー情報を入力する
        fill_in "email", with: ""
        fill_in "password", with: ""
        # ログインボタンを押す
        find("input[name='commit']").click
        # ログインページへ戻されることを確認する
        expect(current_path).to eq "/users/sign_in"

      end
    end
  end
    RSpec.describe 'ユーザー情報の編集', type: :system do
      before do
        @user = FactoryBot.create(:user)
      end
      context 'ユーザー情報の編集ができる時' do
        it '必須項目が記載されていると登録できる' do
        #トップページへ移動する
        visit root_path
        # トップページにログインページへ遷移するボタンがあることを確認する
        expect(page).to have_content("ログイン")
        # ログインページへ遷移する
        visit new_user_session_path
        # 正しいユーザー情報を入力する
        fill_in "email", with: @user.email
        fill_in "password", with: @user.password
        # ログインボタンを押す
        find('input[name="commit"]').click
        # トップページへ遷移することを確認する
        visit root_path
          #トップページにマイページボタンがあることを確認する
          expect(page).to have_content("マイページ")
          #マイページへ移動する
          visit users_path
          #プロフィールボタンがあることを確認する
          expect(page).to have_content("プロフィール")
          #プロフィールへ移動する
          visit users_path
          #プロフィール編集ボタンがあることを確認する
          expect(page).to have_content("プロフィール編集")
          #プロフィール編集へ移動する
          visit edit_user_registration_path
          #必須項目を入力する
          fill_in "nickname", with: @user.nickname
          fill_in "email", with: @user.email
          #更新するボタンを押す
          click_button "更新する"
          #プロフィールページへ遷移することを確認する
          visit users_path
        end
      end
      context 'ユーザー情報の編集ができない時' do
        it '必須項目が空欄だと編集できない' do
          #トップページへ移動する
          visit root_path
          # トップページにログインページへ遷移するボタンがあることを確認する
          expect(page).to have_content("ログイン")
          # ログインページへ遷移する
          visit new_user_session_path
          # 正しいユーザー情報を入力する
          fill_in "email", with: @user.email
          fill_in "password", with: @user.password
          # ログインボタンを押す
          find('input[name="commit"]').click
          # トップページへ遷移することを確認する
          visit root_path
          #トップページにマイページボタンがあることを確認する
          expect(page).to have_content("マイページ")
          #マイページへ移動する
          visit users_path
          #プロフィールボタンがあることを確認する
          expect(page).to have_content("プロフィール")
          #プロフィールへ移動する
          visit users_path
          #プロフィール編集ボタンがあることを確認する
          expect(page).to have_content("プロフィール編集")
          #プロフィール編集へ移動する
          visit edit_user_registration_path
          #必須項目を入力する
          fill_in "nickname", with: ""
          fill_in "email", with: ""
          #更新するボタンを押す
          click_button "更新する"
          #プロフィール編集ページへ戻されることを確認する
         expect(current_path).to eq "/users.user"
        end
      end
    end
