select u.id from users u where (select count(*) from received_messages r where r.user_id = u.user_id) < (select count(*) from messages m where m.user_id = u.user_id);

