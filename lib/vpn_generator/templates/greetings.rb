module Templates
  class Greetings
    def text
      'Good day! This bot is designed to generate free keys for the hidemyna.me site. To get a new key, click the "Generate" button below'
    end

    def reply_markup
      Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: [%w(Generate)])
    end
  end
end
