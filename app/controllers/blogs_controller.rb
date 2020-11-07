class BlogsController < ApplicationController
  before_action :set_blog, only: %i[show edit destroy update]
  before_action :move_to_index, only: %i[edit new]

  def index
    @blogs = Blog.includes(:user).published.order('created_at DESC')
  end

  def confirm
    @blogs = Blog.draft.order("created_at DESC")
  end

  def new
    @blog = Blog.new(user_id: current_user.id)
    @blogs = Blog.where(id: params[:id])     # サイドバーに対してblogのidを配列として送る
    
  end

  def create
    @blog = BlogTags.new(blogtags_params)
    if @blog.valid?
      @blog.save
      flash[:success] = "投稿しました"
      redirect_to user_path(current_user.id)
    else
      render :new
    end
  end

  def destroy
    if @blog.destroy
      redirect_to user_path(current_user.id)
    else
      render :show
    end
  end

  def edit
    @tag_list = @blog.tags.pluck(:tag_name).join(",")
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def show
    @comment = Comment.new
    @comments = @blog.comments.includes(:user)
  end

  def search
    @blogs = Blog.published.search(params[:keyword])
  end

  # 下書き・公開用
  def toggle_status!
    if draft?
      published
    end
  end

  private

  # def blogs_params
  #   params.require(:blog).permit(:title, :body, :image, :status, :comment).merge(user_id: current_user.id)
  # end

  # def blog_params
  #   params.require(:blog).permit(:title, :body, :status, :iamge, :comment, :tag_ids).merge(user_id: current_user.id)
  # end

  def blogtags_params
    params.require(:blog).permit(:title, :body, :status, :iamge, :comment, :tag_ids, :tag_name).merge(user_id: current_user.id)
  end

  def set_blog
    @blog = Blog.find(params[:id])
    @blogs = Blog.where(id: params[:id])
    
  end

  def move_to_index
    redirecto_to root_path unless user_signed_in? || @blog.user.id == current_user.id
  end

  # tag編集時のメソッド
  # def save_tags(saveblog_tag)
  #   current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
  #   old_tags = current_tags - saveblog_tags
  #   new_tags = saveblog_tags - current_tags
  
  #   old_tags.each do |old_name|
  #     self.tags.delete Tag.find(tag_name: old_name)
  #   end

  #   new_tags.each do |new_name|
  #     blog_tag = Tag.find_or_create_by(tag_name: new_name)
  #     self.tags << blog_tag
  #   end
  # end

end

