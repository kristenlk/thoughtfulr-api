class User < ActiveRecord::Base
  has_secure_password

  before_create :set_token
  # When I call create, before it actually saves the object, the set_token method will be invoked. Which means the token will have been set.

  validates :email, uniqueness: true

  def self.login(email, password)
    user = find_by email: email
    user.login password if user
  end

  def login(password)
    authenticate(password) && set_token && save! && token
  end

  private

  def set_token
    self.token = SecureRandom.hex
  end

end
