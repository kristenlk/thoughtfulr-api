class Profile < ActiveRecord::Base
  belongs_to :user, inverse_of: :profile

  validates_presence_of :moniker, :location, :email_or_phone, :selected_time

  validates :moniker,
            length: { minimum: 1, maximum: 10 }

  validates :email_or_phone,
            :inclusion  => { :in => [ 'email', 'phone' ],
            :message    => "%{value} is not a valid selection." }

  validates :selected_time,
            :inclusion  => { :in => [ 'morning', 'afternoon', 'evening' ],
            :message    => "%{value} is not a valid selection." }
end
