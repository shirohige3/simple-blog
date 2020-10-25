class Blog < ApplicationRecord
  enum status: { draft: 0, published: 1 }

  has_many   :comments, dependent: :destroy
  belongs_to :user
  has_one_attached :image, dependent: :destroy
  has_rich_text :body    #Actiontext

  with_options presence: true do
    validates :title
    validates :body
  end

  # Blogテーブルとの検索データのやり取り
  def self.search(search)
    if search != ''
      Blog.where('title LIKE(?)', "%#{search}%")
    else
      Blog.all
    end
  end
end
