require 'json'

class OverviewController < ApplicationController
  skip_before_action :require_login, only: [:index]
  skip_before_action :require_complete_user, only: [:index]

  def index
    redirect_to show if user_signed_in?
  end

  def show
    @athlete = current_user
    @routes = StravaService.new(@athlete).routes
  end
end
