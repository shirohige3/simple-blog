class UsersController < ApplicationController
  before_action :set_user, only: %i[show destroy edit]
  before_action :move_to_index, only: %i[show edit]

  def index
    @users = User.includes(:blog).order('created_at DESC')
    # @blogs = User.blogs
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

  # def destroy
  #  if @user.destroy
  #     redirecto_to root_path
  #  else
  #     render :show
  #  end
  # end

  # def update
  #   if @user.update
  #     redirect_to user_edit_path
  #   else
  #     render "users#show"
  #   end
  # end

  def show
    @blogs = current_user.blogs
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :full_name, :full_name_kana, :birth_date, :introduction, :image).merge(blog_id: blog.id)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def move_to_index
    redirecto_to root_path unless user_signed_in? || @user.id == current_user.id
  end
end
