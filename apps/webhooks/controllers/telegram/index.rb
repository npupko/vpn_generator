require 'telegram/bot'

module Webhooks::Controllers::Telegram
  class Index
    include Webhooks::Action

    def call(params)
      result = Interactors::Users::Create.new.call(params[:message][:from])
      if result.success?
      end
      # status 200, 'Ok'
      # token = ENV['TELEGRAM_TOKEN']
      # @bot = Telegram::Bot::Client.new(token)
      # if params[:message][:text].eql? '/start'
      #   greeting(params[:message][:chat][:id])
      # elsif params[:message][:text].eql? 'Generate'
      #   send_key(params[:message][:chat][:id])
      # end
    end

    def send_key(chat_id); end

    def greeting(chat_id)
      text = 'Good day! This bot is designed to generate free keys for the hidemyna.me site. To get a new key, click the "Generate" button below'
      @bot.api.send_message(chat_id: chat_id, text: text, reply_markup: reply_markup)
    end

    def reply_markup
      kb = [ Telegram::Bot::Types::KeyboardButton.new(text: 'Generate') ]
      Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb)
    end
  end
end
