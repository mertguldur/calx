class User < ApplicationRecord
  belongs_to :time_zone

  before_save { self.email = email.downcase }
  before_create :create_remember_digest

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
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

  def create_remember_digest
    self.remember_digest = User.digest(User.new_remember_token)
  end
end
