class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?
  

  protected

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  #  deviseコントローラーに追加したカラムをkeyで追加する
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[nickname full_name full_name_kana birth_date introduction])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[nickname full_name full_name_kana birth_date introduction])
  end
end
