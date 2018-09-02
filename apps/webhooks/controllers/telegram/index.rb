require 'telegram/bot'

module Webhooks::Controllers::Telegram
  class Index
    include Webhooks::Action

    def call(params)
      puts params[:message]
      result = Interactors::Users::Create.new.call(params[:message][:from])
      respond_to result.user if result.success?
    end

    private

    def respond_to(user)
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
  end
end
