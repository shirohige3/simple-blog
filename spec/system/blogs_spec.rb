require 'rails_helper'

RSpec.describe "Blogs", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @blog = FactoryBot.create(:blog)
  end
  context "ブログを投稿できる時" do
    it "ログインしているユーザーは投稿できる" do
    #トップページへ遷移する
    visit root_path
    #ログインする
    visit new_user_session_path
    fill_in "email", with: @user.email
    fill_in "password", with: @user.password
    click_button "ログイン"
    expect(current_path).to eq root_path
    #記事を書くボタンがあることを確認する
    expect(page).to have_content "記事を書く"
    #投稿ページへ移動する
    visit new_blog_path
    #必須項目(タイトル)を入力する
    fill_in "title", with: @blog.title
    #投稿ボタンを押すとblogモデルのカウントが1上昇することを確認する
    expect{
      click_button "投稿"
    }.to change{Blog.count}.by(1)
    #マイページへ遷移することを確認する
    visit user_path(@user.id)
    #マイページには先ほど投稿したブログが存在することを確認する
    expect(page).to have_content @blog.title
    end
  end
  context "ブログを投稿できない時" do
    it "ログインしていないと投稿できない" do
      #トップページへ遷移する
      visit root_path
      #記事を書くボタンがないことを確認する
      expect(page).to have_no_content("記事を書く")
    end
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
