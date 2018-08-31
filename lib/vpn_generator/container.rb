class Container
  extend Dry::Container::Mixin

  register(:user_repo) { UserRepository.new }
  register(:proxy_repo) { ProxyRepository.new }
  register(:bot) { Telegram::Bot::Client.new(ENV['TELEGRAM_TOKEN']) }
  register(:key_generator) { Interactors::Vpn::Generate.new }
  register(:proxy_generator) { Interactors::Proxy::Generate.new }

  namespace(:vpn) do
    register(:email) { Interactors::Vpn::Email.new }
  end
end

Import = Dry::AutoInject(Container)
