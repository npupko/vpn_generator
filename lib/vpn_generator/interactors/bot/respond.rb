require 'hanami/interactor'

module Interactors
  module Bot
    class Respond
      include Hanami::Interactor
      include Import['bot']

      def call(user:, text:, reply_markup: nil)
        bot.api.send_message(
          chat_id: user.messenger_id,
          text: text,
          reply_markup: reply_markup
        )
      end
    end
  end
end
