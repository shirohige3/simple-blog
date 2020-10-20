class Blog < ApplicationRecord
  has_many   :comments, dependent: :destroy
  belongs_to :user
  has_one_attached :image, dependent: :destroy

  with_options presence: true do
  validates :title
  validates :text
  end
  
  # Blogテーブルとの検索データのやり取り
  def self.search(search)
    if search !=""
      Blog.where("title LIKE(?)","%#{search}%")
    else
      Blog.all
    end
  end

end
