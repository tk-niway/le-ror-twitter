class ApplicationController < ActionController::Base
  before_action :authenticate_user! # ログインしていないとログイン画面に遷移する

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # deviseのストロングパラメーターを設定する
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(_resource)
    posts_path
  end
end
