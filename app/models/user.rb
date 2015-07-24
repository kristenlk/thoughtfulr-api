class User < ActiveRecord::Base
  has_secure_password

  before_create :set_token
  # When I call create, before it actually saves the object, the set_token method will be invoked. Which means the token will have been set.

  validates :email, uniqueness: true

  def self.login(email, password)
    user = find_by email: email
    # returns either the user (if it finds the email address passed) or nil
    user = user.authenticate password if user
    # .authenticate is a method we get from has_secure_password
    # if I have a user, authenticate the user with a password, return the user if the user is there. Return false if otherwise.
    user.set_token && user.save! if user
    user.token if user
    # if I find a user, return the token.
  end

  # private

  def set_token
    self.token = SecureRandom.hex
  end

end
