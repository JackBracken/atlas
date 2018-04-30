require 'strava/api/v3'

class StravaService
  attr_reader :user, :identity, :client

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

  def routes
    @client.list_athlete_routes
  end

  # cattr_reader :client, instance_accessor: false do
  # Strava::Api::V3::Client.new(access_token: ENV['STRAVA_API_TOKEN'])
  # end
  # def self.athlete
  # client.retrieve_current_athlete
  # end
end
