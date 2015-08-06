class User < ActiveRecord::Base
  has_one :profile, inverse_of: :user, autosave: true
  has_many :messages, inverse_of: :user
  has_many :received_messages, inverse_of: :user
  has_many :received_message_bodies, through: :received_messages, source: :message

  has_secure_password

  before_create :set_token
  # When I call create, before it actually saves the object, the set_token method will be invoked. Which means the token will have been set.

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
  # this allows me to type User.login in rails c

  def login(password)
    authenticate(password) && set_token && save! && token
  end

  private

  def set_token
    self.token = SecureRandom.hex
  end

  def sent_msg_count
    @current_user.messages.count
  end

  def received_msg_count
    @current_user.received_messages.count
  end

  # validate do |user|
  #   # school.students.each do |student|
  #   #   next if student.valid?
  #   #   student.errors.full_messages.each do |msg|
  #   #     # you can customize the error message here:
  #   #     errors.add_to_base("Student Error: #{msg}")
  #   #   end
  #   # end
  #   next if user.valid?
  #   user.profile.errors.full_messages.each do |msg|
  #     errors[:base] << "Profile Error: #{msg}"
  #   end
  # end

end
