require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end
  describe "コメントを投稿する" do
    context "コメントが投稿できる時" do
      it "textが存在していれば投稿できる" do
        expect(@comment).to be_valid
      end
      context "コメントが投稿できない時" do
        it "textが空だと投稿できない" do
        @comment.text = ""
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Text can't be blank")
       end
      end
    end
  end
end
