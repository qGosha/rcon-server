class User < ApplicationRecord
  has_secure_password
  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, 
  format: { with: VALID_EMAIL_REGEX }, 
  uniqueness: { case_sensitive: false }
  # we can allow nil since has_secure_password has it's own validation
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  # Returns the hash digest of the given string.
  class << self  
    def digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def new_token
        SecureRandom.urlsafe_base64
    end
  end 

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  private

  def downcase_email
    email.downcase!
  end
  
end
