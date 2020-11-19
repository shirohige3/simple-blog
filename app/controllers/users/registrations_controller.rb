# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  prepend_before_action :authenticate_scope!, only: %i[edit edit_password update update_password destroy]
  before_action :search_blog, only: [:edit]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  def edit
    @user = current_user
  end

  # PUT /resource
  def update
    @user = current_user
    pp @user
    if @user.update(account_update_params)
      sign_in(@user, bypass: true) if current_user.id == @user.id
      redirect_to user_registration_path(@user.id)
    else
      render action: :edit
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[nickname email password birth_date introduction])
  end

  def update_resource(resource, params)
    # if params[:password].blank? && params[:password_confirmation].blank? && params[:current_password].blank?
    resource.update_without_password(params)
    # else
    # resource.update_with_password(params)
    # end
  end

  # update後にマイページ
  def after_update_path_for(_resource)
    user_path(@user.id)
  end

  def search_blog
    @q = Blog.ransack(params[:q]) # 検索オブジェクト生成
  end
  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
