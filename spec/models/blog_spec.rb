require 'rails_helper'

RSpec.describe Blog, type: :model do
  before do
    @blog = FactoryBot.build(:blog)
  end
  describe '記事を投稿する' do
    context '記事が投稿できる時' do
      it 'title,bodyが存在している時' do
        expect(@blog).to be_valid
      end
    end
    context '記事を投稿できない時' do
      it 'titleがないと投稿できない' do
        @blog.title = ''
        @blog.valid?
        expect(@blog.errors.full_messages).to include("Title を入力してください。")
      end
      it 'bodyがないと投稿できない' do
        @blog.body = ''
        @blog.valid?
        expect(@blog.errors.full_messages).to include("Body を入力してください。")
      end
    end
  end
end
