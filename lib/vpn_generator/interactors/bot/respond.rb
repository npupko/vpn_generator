require 'hanami/interactor'

module Interactors
  module Bot
    class Respond
      include Hanami::Interactor
      include Import['bot']

      def call(user:, template:)
        bot.api.send_message(
          chat_id: user.messenger_id,
          text: template.text,
          reply_markup: template.reply_markup
        )
      end
    end
  end
end
