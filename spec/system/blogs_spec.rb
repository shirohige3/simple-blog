require 'rails_helper'

# RSpec.describe "Blogs", type: :system do
#   before do
#     @user = FactoryBot.create(:user)
#     @blog = FactoryBot.create(:blog)
#   end
#   context "ブログを投稿できる時" do
#     it "ログインしているユーザーは投稿できる" do
#     #トップページへ遷移する
#     visit root_path
#     #ログインする
#     visit new_user_session_path
#     fill_in "email", with: @user.email
#     fill_in "password", with: @user.password
#     click_button "ログイン"
#     expect(current_path).to eq root_path
#     #記事を書くボタンがあることを確認する
#     expect(page).to have_content "記事を書く"
#     #投稿ページへ移動する
#     visit new_blog_path
#     #必須項目(タイトル)を入力する
#     fill_in "title", with: @blog.title
#     #投稿ボタンを押すとblogモデルのカウントが1上昇することを確認する
#     expect{
#       click_button "投稿"
#     }.to change{Blog.count}.by(1)
#     #マイページへ遷移することを確認する
#     visit user_path(@user.id)
#     #マイページには先ほど投稿したブログが存在することを確認する
#     expect(page).to have_content @blog.title
#     end
#   end
#   context "ブログを投稿できない時" do
#     it "ログインしていないと投稿できない" do
#       #トップページへ遷移する
#       visit root_path
#       #記事を書くボタンがないことを確認する
#       expect(page).to have_no_content("記事を書く")
#     end
#   end
# end
  RSpec.describe 'ブログ編集・削除', type: :system do
    before do
      @blog1 = FactoryBot.create(:blog)
      @blog2 = FactoryBot.create(:blog)
    end
 context "ブログを編集できる時" do
   it "投稿者が編集できる" do
     #トップページへ遷移しログインする
     visit new_user_session_path
     fill_in "email", with: @blog1.user.email
     fill_in "password", with: @blog1.user.password
     click_button "ログイン"
     visit root_path
     #ブログページへ遷移する
     visit blog_path(@blog1.id)
     #編集ボタンがあることを確認する
     expect(page).to have_content("編集する")
     #編集ボタンを押して編集ページへ遷移する
      find("input[name='commit']").click
     visit edit_blog_path(@blog1.id)
     #ブログ内容を編集する
     fill_in "title", with: "#{@blog1.title}+編集したタイトル"
     #更新するボタンを押す
     click_button "投稿"
     #マイページへ移動する
     visit users_path(@blog1.user.id)
   end
 end
  context "ブログを編集できない時" do
    it "投稿者でない時" do
      #ログインページからログインする(@blog1ユーザー)
      visit new_user_session_path
      fill_in "email", with: @blog1.user.email
      fill_in "password", with: @blog1.user.password
      click_button "ログイン"
      #ブログページへ遷移する(@blog2)
      visit blog_path(@blog2.id)
      #編集ボタンがないことを確認する
      expect(page).to have_no_content("編集する")
    end
  end
  context "ブログを削除できる時" do
    it "投稿者であれば削除できる" do
      #ログインページからログインする(@blog1ユーザー)
      visit new_user_session_path
      fill_in "email", with: @blog1.user.email
      fill_in "password", with: @blog1.user.password
      click_button "ログイン"
      #ブログページへ遷移する(@blog1)
      visit blog_path(@blog1.id)
      #削除するボタンがある事を確認する
      expect(page).to have_content("削除する")
      #削除ボタンを押す
      find("input[name='commit']").click
      #マイページへ移動する
      visit user_path(@blog1.user.id)
      #マイページに@blog1がない事を確認する
      expect(page).to have_no_content @blog1
    end
  end
  context "ブログを削除できない時" do
    it "投稿者でなければ削除できない" do
      #ログインページからログインする(@blog1ユーザー)
      visit new_user_session_path
      fill_in "email", with: @blog1.user.email
      fill_in "password", with: @blog1.user.password
      click_button "ログイン"
      #ブログページへ遷移する(@blog2)
      visit blog_path(@blog2.id)
      #削除ボタンがない事を確認する
      expect(page).to have_no_content("削除する")
    end
  end
 end
