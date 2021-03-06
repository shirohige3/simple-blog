class Blog < ApplicationRecord
  enum status: { draft: 0, published: 1 }

  has_many   :blog_tags
  has_many   :tags, through: :blog_tags, dependent: :destroy
  has_many   :comments, dependent: :destroy
  belongs_to :user
  has_one_attached :image, dependent: :destroy
  has_rich_text :body    # Actiontext

  validates :title,    presence: true

  # Blogテーブルとの検索データのやり取り
  def self.search(search)
    if search != ''
      @tag = Tag.where('tag_name LIKE(?)', "%#{search}%")
      @blog = Blog.where('title LIKE(?)', "%#{search}%")
        blogtags = BlogTag.where(tag_id: @tag.ids)
        blogtag = blogtags.pluck(:blog_id)
        blog = Blog.where(id: blogtag)
        @blog += blog
        @blog.uniq   #uniqで重複したやつは消す
    end
  end
end
