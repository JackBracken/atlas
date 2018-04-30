class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create]
  skip_before_action :require_complete_user, only: [:create]

  # GET /auth/:provider/callback
  def create
    user = User.find_or_create_from_auth_hash!(auth_hash)
    self.current_user = user

    if user.just_created?
      redirect_to edit_user_path
    else
      redirect_to root_path
    end
  end

  # GET /logout
  def destroy
    self.current_user = nil
    redirect_to root_path
  end

  def failure
    render text: params.inspect
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
