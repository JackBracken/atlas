class UsersController < ApplicationController
  skip_before_action :require_complete_user, only: [:edit, :update]

  # GET /user/edit
  def edit; end

  # PUT /user
  def update
    if current_user!.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  protected

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
