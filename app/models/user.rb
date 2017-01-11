class User < ApplicationRecord
  lookup_for :time_zone
  has_many :events

  before_save { self.email = email.downcase }
  before_create :create_api_id
  before_create :create_remember_digest

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 500 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :time_zone, presence: true

  has_secure_password
  validates_length_of :password, minimum: 6, allow_blank: true
  validates_presence_of :password, on: :create

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_api_id
    self.api_id = SecureRandom.urlsafe_base64
  end

  def create_remember_digest
    self.remember_digest = User.digest(User.new_remember_token)
  end
end
