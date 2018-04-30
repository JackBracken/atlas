class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login
  before_action :require_complete_user

  protected

  def user_signed_in?
    !!current_user
  end
  helper_method :user_signed_in?

  def current_user
    @current_user ||= User.find_by_auth_token(cookies.signed[:user_token]) unless cookies.signed[:user_token].blank?
  end
  helper_method :current_user

  def current_user!
    return unless user_signed_in?
    current_user.respond_to?(:item) ? current_user.item : current_user
  end
  helper_method :current_user!

  def current_user=(user)
    session.destroy if session.respond_to? :destroy
    reset_session
    cookies.delete :user_token

    cookies.permanent.signed[:user_token] = { value: user.try(:auth_token), httponly: true }
    @current_user = user
  end

  def require_login
    redirect_to root_path && return unless user_signed_in?
  end

  def require_complete_user
    redirect_to edit_user_path && return if user_signed_in? && !current_user.complete?
  end
end
