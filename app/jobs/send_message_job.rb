class SendMessageJob
  include ActiveModel::Model

  def perform
    users.each do |user|
      message_to_send = find_random_message(user)

      if message_to_send.present?
        message_to_send.send_message(user)
      end
    end
  end

  private

  def users
    User.find_by_sql(
      "
      SELECT u.id, p.email_or_phone, p.phone_number
      FROM users u
      INNER JOIN profiles p
         ON u.id = p.user_id
      WHERE
        p.email_or_phone = 'phone'
        AND
        (SELECT count(*)
          FROM received_messages r
          WHERE r.user_id = u.id)
        <
        (SELECT count(*)
          FROM messages m
          WHERE m.user_id = u.id)
        AND
          p.opted_in = TRUE
        AND
          p.selected_time = ''#{time}'';
      "
    )
  end

  def find_random_message(user)
    Message.where.not(
      user_id: user.id,
      id: user.received_messages.map(&:message_id)
    ).first
  end

  def time
    return 'morning' if Time.now.strftime("%l").to_i == 9
    return 'afternoon' if Time.now.strftime("%l").to_i == 2
    return 'evening' if Time.now.strftime("%l").to_i == 7
  end
end
