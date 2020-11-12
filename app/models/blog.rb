class Blog < ApplicationRecord
  enum status: { draft: 0, published: 1 }
  
  has_many   :blog_tags
  has_many   :tags, through: :blog_tags, dependent: :destroy
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
    # if search != ''
    #   Blog.where('title LIKE(?)', "%#{search}%")
    # elsif params[:tag_name]
    #   Blog.where("tag LIKE(?)", "%#{params[:tag_name]}%")
    # else
    #   Blog.all
    # end

    if search == "#{:tag_name}" && search != ""
      Blog.where("tag LIKE(?)", "%#{search}")
    elsif search != ''
      Blog.where('title LIKE(?)', "%#{search}%")
    else
      Blog.all
    end
  end
end