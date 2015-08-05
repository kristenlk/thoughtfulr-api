class Profile < ActiveRecord::Base
  belongs_to :user, inverse_of: :profile

  # validates_presence_of :moniker, :location, :email_or_phone, :selected_time

  validates :location, presence: true

  validates :moniker, presence: true,
            length: { minimum: 1, maximum: 10 }

  validates :email_or_phone, presence: true,
            :inclusion  => { :in => [ 'email', 'phone' ],
            :message    => "%{value} is not a valid selection." }

  validates :phone_number, presence: true,
            if: Proc.new { |profile| profile.email_or_phone == 'phone' }

  validates :selected_time, presence: true,
            :inclusion  => { :in => [ 'morning', 'afternoon', 'evening' ],
            :message    => "%{value} is not a valid selection." }


end
