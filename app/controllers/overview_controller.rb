require 'json'

class OverviewController < ApplicationController
  skip_before_action :require_login, only: [:index]
  skip_before_action :require_complete_user, only: [:index]

  def index
    redirect_to show if user_signed_in?
  end

  def demo
    @routes = [
      { title: 'France Holiday', img: '/assets/france.jpg', routes: 5, total_km: 513.86 },
      { title: 'Wild Atlantic Way', img: '/assets/ireland.jpg', routes: 11, total_km: 1371.82 },
      { title: 'Orwell Wheelers Spins', img: '/assets/orwell.jpg', routes: 22, total_km: 2001.73 },
      { title: 'Marathon Training', img: '/assets/marathon.jpg', routes: 18, total_km: 123.80 },
      { title: 'Dublin Mountain Trails', img: '/assets/mountain.jpg', routes: 8, total_km: 67.99 },
      { title: 'Park Runs', img: '/assets/parkrun.jpg', routes: 16, total_km: 81.02 },
      { title: 'Audax Ireland', img: '/assets/audax.jpg', routes: 32, total_km: 7813.19 },
      { title: 'Wicklow 200 Training Spins', img: '/assets/wicklow.jpg', routes: 14, total_km: 1581.20 }
    ]
  end

  def routes
    @routes = StravaService.new(current_user).all_athlete_routes
    RouteImportWorker.perform_async('1234567890')
  end

  def show
    @athlete = current_user
    @routes = StravaService.new(@athlete).all_athlete_routes
  end
end
