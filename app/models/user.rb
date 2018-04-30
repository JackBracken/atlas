class User < ActiveRecord::Base
  has_many :identities, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true
  validates :auth_token, presence: true, uniqueness: true

  before_validation :generate_auth_token, on: [:create]

  def complete?
    name.present? && email.present?
  end

  def just_created?
    persisted? && created_at == updated_at
  end

  def self.find_or_create_from_auth_hash!(auth_hash)
    find_from_auth_hash(auth_hash) || create_from_auth_hash!(auth_hash)
  end

  def self.find_from_auth_hash(auth_hash)
    Identity.where(provider: auth_hash[:provider], uid: auth_hash[:uid]).first.try(:user)
  end

  def self.create_from_auth_hash!(auth_hash)
    transaction do
      user = create!(
        name: auth_hash[:info][:name],
        email: auth_hash[:info][:email]
      )
      user.identities.create!(
        provider: auth_hash[:provider],
        uid: auth_hash[:uid],
        info: auth_hash[:info],
        credentials: auth_hash[:credentials],
        extra: auth_hash[:extra]
      )
      user.reload
    end
  end

  def strava_client
    @strava_client ||= StravaService.new(self).client
  end

  private

  def generate_auth_token
    self.auth_token ||= SecureRandom.urlsafe_base64(24)
  end
end
