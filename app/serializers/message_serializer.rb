class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :profile_info, :created_at

  def profile_info
    object.user.profile
  end

  def created_at
    object.created_at.strftime('on %B %d, %Y at %l:%M %p')
  end
end
