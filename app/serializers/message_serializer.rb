class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :profile_info, :created_at

  def profile_info
    object.user.profile
  end

  def created_at
    object.created_at.in_time_zone('Eastern Time (US & Canada)').strftime('on %B %d, %Y at %l:%M %p Eastern time')
  end

end
