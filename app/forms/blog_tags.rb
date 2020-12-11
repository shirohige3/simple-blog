class BlogTags
  include ActiveModel::Model
  attr_accessor :title, :status, :tag_name, :body, :comment, :image, :user_id, :tag_ids, :tag_id, :blog_id

  # blog用バリデーション
  validates :title,     presence: true

  def save
    blog = Blog.create(title: title, status: status, body: body, user_id: user_id, image: image)
    # tagを分割、作成して添付する
    tag_list = tag_ids.split(',')
    tag_list.each do |tag_name|
      @tag = Tag.where(tag_name: tag_name).first_or_initialize
      @tag.save
      @blogtag = BlogTag.create(blog_id: blog.id, tag_id: @tag.id)
    end
  end
end
