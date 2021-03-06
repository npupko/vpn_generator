require 'hanami/interactor'

module Interactors
  module Users
    class Create
      include Hanami::Interactor
      include Import[:user_repo]

      expose :user

      def call(user_data)
        find_user!(user_data)
        create_user!(user_data) unless @user
      end

      def find_user!(user_data)
        @user = user_repo.find_by(messenger_id: user_data[:id])
      end

      def create_user!(user_data)
        @user = user_repo.create_from_telegram_webhook(user_data)
        error 'User not created' unless @user
      end
    end
  end
end
