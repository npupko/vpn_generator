class UserRepository < Hanami::Repository
  def create_from_telegram_webhook(user_data)
    create(
      messenger_id: user_data[:id],
      first_name: user_data[:first_name],
      last_name: user_data[:last_name],
      username: user_data[:username],
      language_code: user_data[:language_code]
    )
  end

  def find_by(attribute = {})
    users.where(**attribute).first
  end

  def key_sended(id)
    user = find(id)
    update(id, last_key_generated_at: Time.now, keys_generated: user.keys_generated + 1)
  end
end
