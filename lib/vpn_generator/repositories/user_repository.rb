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
end
