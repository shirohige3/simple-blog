class BlogsController < ApplicationController
  before_action :set_blog, only: %i[show edit destroy update]
  before_action :move_to_index, only: %i[edit new]

  def index
    @blogs = Blog.includes(:user).published.order('created_at DESC')
  end

  def confirm
    @blogs = Blog.draft.order('created_at DESC')
  end

  def new
    @blog = Blog.new(user_id: current_user.id)
    @blogs = Blog.where(id: params[:id])     # サイドバーに対してblogのidを配列として送る
  end

  def create
    @blog = BlogTags.new(blogtags_params)
    if @blog.valid?
      @blog.save
      redirect_to user_path(current_user.id)
    else
      @blog = Blog.new(user_id: current_user.id)  #これだとエラ〜メッセージが出ないのでflashなどを使用して改善する。
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
    @tag_list = @blog.tags.pluck(:tag_name).join(',')
  end

  def update
    @newblog = BlogTags.new(blogtags_params)
    if @newblog.valid?
      @newblog.save
      @blog.destroy
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def show
    @user = current_user
    @comment = Comment.new
    @comments = @blog.comments.includes(:user)
  end

  def search
    @blogs = Blog.published.order('created_at DESC').search(params[:keyword])
    @blogs = [] if @blogs.nil?        #@bligsが空なら配列なしで展開する。
  end

  # 下書き・公開用
  def toggle_status!
    published if draft?
  end

  private

  def blogs_params
    params.require(:blog).permit(:title, :body, :image, :status, :comment).merge(user_id: current_user.id)
  end

  def blog_params
    params.require(:blog).permit(:title, :body, :status, :image, :comment, :tag_ids).merge(user_id: current_user.id)
  end

  def blogtags_params
    params.require(:blog).permit(:title, :body, :status, :image, :comment, :tag_ids, :tag_name).merge(user_id: current_user.id)
  end

  def set_blog
    @blog = Blog.find(params[:id])
    @blogs = Blog.where(id: params[:id])
  end

  def move_to_index
    redirecto_to root_path unless user_signed_in? || @blog.user.id == current_user.id
  end

  # tag編集時のメソッド 構築途中
  # def save_tags(tag_list)
  #   current_tags = tag_list
  #   new_tags = blogtags_params[:tag_ids]
  #   tag_list = current_tags.replace(new_tags)
  #   new_tag_arry = tag_list.split(',')
  #   @tags = []
  #   new_tag_arry.each do |tag_name|
  #     @tag = Tag.where(tag_name: tag_name).first_or_initialize
  #     @tag.save!
  #     @tags << @tag
  #   end
  # end
end
