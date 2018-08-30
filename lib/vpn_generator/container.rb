class Container
  extend Dry::Container::Mixin

  register(:user_repo) { UserRepository.new }
  register(:bot) { Telegram::Bot::Client.new(ENV['TELEGRAM_TOKEN']) }
end

Import = Dry::AutoInject(Container)
