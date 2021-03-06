class Profile < ActiveRecord::Base
  belongs_to :user, inverse_of: :profile

  after_initialize :set_default_values

  validates :location, presence: true

  validates :moniker, presence: true,
            length: { minimum: 1, maximum: 10 }

  validates :email_or_phone,
            inclusion: {
              in: [ "email", "phone" ],
              message: "%{value} is not a valid selection."
            }

  validates :phone_number, presence: true,
            if: Proc.new { |profile| profile.email_or_phone == "phone" }

  validates :selected_time, presence: true,
            inclusion: {
              :in => [ "morning", "afternoon", "evening" ],
              message: "%{value} is not a valid selection."
            }

  validates_inclusion_of :opted_in, in: [ true, false ]

  def set_default_values
    self.opted_in = true
    self.email_or_phone = "phone"
  end

  def phone?
    email_or_phone == "phone"
  end
end
