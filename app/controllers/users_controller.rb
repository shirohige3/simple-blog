class UsersController < ApplicationController
  before_action :set_user, only: %i[show destroy edit]
  before_action :move_to_index, only: %i[ edit]
  before_action :search_blog

  def index
    @users = User.includes(:blog).order('created_at DESC')
    @user = current_user
    @blogs = current_user.blogs
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  def search; end

  def show
    @user = User.find(params[:id])
    if @user == current_user
     @blogs = current_user.blogs.order('created_at DESC')
    else
      @blogs = @user.blogs.order("created_at DESC")
    end
  end

  def follow_list
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :full_name, :full_name_kana, :birth_date, :introduction, :image, :keyword).merge(blog_id: blog.id)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def move_to_index
    redirect_to root_path unless user_signed_in? || @user.id == current_user.id
  end

  def search_blog
    @q = Blog.ransack(params[:q])   # 検索オブジェクト生成
  end
end
