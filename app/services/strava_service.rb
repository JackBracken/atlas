require 'strava/api/v3'

class StravaService
  attr_reader :user, :identity, :client

  PER_PAGE_DEFAULT = 200.freeze!

  def initialize(user)
    @user = user
    @identity = @user.identities.where(provider: 'strava').first

    raise "User ##{@user.id} does not have strava identity" if @identity.nil?
    raise "User ##{@user.id} Strava access token not found" if @identity.credentials['token'].blank?

    @client = Strava::Api::V3::Client.new(access_token: @identity.credentials['token'])
  end

  def activities
    @client.list_athlete_activities
  end

  def all_athlete_routes
    @routes = []
    page = 1
    loop do
      routes = @client.list_athlete_routes(page: page, per_page: PER_PAGE_DEFAULT)
      break unless routes.any?
      @routes.push routes
      page += 1
    end
    @routes
  end
end
