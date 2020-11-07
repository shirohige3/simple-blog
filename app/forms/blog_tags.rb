class BlogTags

  include ActiveModel::Model
  attr_accessor :title, :status, :tag_name, :body, :comment, :iamge, :user_id, :tag_ids, :tag_id, :blog_id

  # blog用バリデーション
  with_options presence: true do
    validates :title
    validates :body
  end

  def save
    blog = Blog.create(title: title, status: status, body: body, user_id: user_id)
    # tagを分割、作成して添付する
    tag_list = tag_ids.split(",")
    tag_list.each do |tag_name|
    @tag = Tag.where(tag_name: tag_name).first_or_initialize
    @tag.save
    BlogTag.create(blog_id: blog.id, tag_id: @tag.id)
    end
  end
  
  private
  def save_tags(save_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - save_tags
    new_tags = save_tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find(tag_name: old_name)
    end

    new_tags.each do |new_name|
      blog_tag = Tag.find_or_created_by(tag_name: new_name)
      self.tags << blog_tag
    end
  end

end



  
  