class BlogsController < ApplicationController
  before_action :set_blog, only:[:show, :edit, :destroy, :update]
  before_action :move_to_index, only:[:edit, :new]

  def index
    @blogs = Blog.includes(:user).order("created_at DESC")
  end

  def new
    @blog = Blog.new(user_id: current_user.id)
    @blogs = Blog.where(id: params[:id])     # サイドバーに対してblogのidを配列として送る
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.valid?
      @blog.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    if @blog.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def update
    if @blog.update(blog_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    @comment = Comment.new
    @comments = @blog.comments.includes(:user)
  end

  def search
    @blogs = Blog.search(params[:keyword])
  end


    private
     def blog_params
      params.require(:blog).permit(:title, :image, :text, :status, :comment).merge(user_id: current_user.id)
     end

     def set_blog
      @blog = Blog.find(params[:id])
      @blogs = Blog.where(id: params[:id])
     end

     def move_to_index
      redirecto_to root_path unless (user_signed_in? ||  @blog.user.id == current_user.id)
     end
end
