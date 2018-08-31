require 'telegram/bot'

module Webhooks::Controllers::Telegram
  class Index
    include Webhooks::Action

    def call(params)
      puts params[:message]
      result = Interactors::Users::Create.new.call(params[:message][:from])
      if result.success?
        respond_to result.user
      end
    end

    def respond_to(user)
      return gtfo!(user) unless params[:message][:from][:username].eql? 'LazyNick'
      return send_message(user.id, 'Greetings') if params[:message][:text].eql? '/start'
      key_generating(user) if params[:message][:text].eql? 'Generate'
    end

    def key_generating(user)
      return not_yet(user) unless more_than_one_day_from_last_generating(user)
      send_message(user.id, 'GeneratedKey')
      send_message(user.id, 'PleaseWait')
      UserRepository.new.key_sended(user.id)
    end

    def not_yet(user)
      send_message(user.id, 'NotYet')
    end

    def more_than_one_day_from_last_generating(user)
      (Time.now - user.last_key_generated_at) > 24 * 60 * 60
    end

    def send_message(user_id, template_name)
      Bot::RespondWorker.perform_async(user_id: user_id, template_name: template_name)
    end

    def gtfo!(result)
      Interactors::Bot::Respond.new.call(user: user, text: development)
    end

    def development
      'The bot is currently under development. Thanks for your patience'
    end
  end
end
