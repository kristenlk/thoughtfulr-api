class User < ActiveRecord::Base
  has_one :profile, inverse_of: :user, autosave: true
  has_many :messages, inverse_of: :user
  has_many :received_messages, inverse_of: :user
  has_many :received_message_bodies, through: :received_messages, source: :message

  has_secure_password

  before_create :set_token

  validates :email, presence: true,
                    uniqueness: true,
                    format: {
                      with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
                    }

  before_save :downcase_email

  def downcase_email
    self.email = email.downcase
  end

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
