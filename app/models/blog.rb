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
    if search != ''
      Blog.where('title LIKE(?)', "%#{search}%")
    else
      Blog.all
    end
  end
end

# tag保存用
# def save_tags(tag)
#   current_tag = self.tags.pluck(:tag_name) unless self.tags.nil?
#   old_tag = current_tag - tag
#   new_tag = tag - current_tag

#   old_tag.each do |old_name|
#     self.tags.delete Tag.find(tag_name: old_name)
#   end

#   new_tag.each do |new_name|
#     blog_tag = Tag.find_or_create_by(tag_name: new_name)
#     self.tags << blog_tag
#   end
# end
