require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require 'sidekiq/web'
require_relative '../lib/vpn_generator'
require_relative '../apps/webhooks/application'
require_relative '../apps/web/application'

Haml::TempleEngine.disable_option_validator!

Hanami.configure do
  mount Webhooks::Application, at: '/webhooks'
  mount Web::Application, at: '/'

  model do
    ##
    # Database adapter
    #
    # Available options:
    #
    #  * SQL adapter
    #    adapter :sql, 'sqlite://db/vpn_generator_development.sqlite3'
    #    adapter :sql, 'postgresql://localhost/vpn_generator_development'
    #    adapter :sql, 'mysql://localhost/vpn_generator_development'
    #
    adapter :sql, ENV.fetch('DATABASE_URL')

    ##
    # Migrations
    #
    migrations 'db/migrations'
    schema     'db/schema.sql'
  end

  mailer do
    root 'lib/vpn_generator/mailers'

    # See http://hanamirb.org/guides/mailers/delivery
    delivery :test
  end

  environment :development do
    # See: http://hanamirb.org/guides/projects/logging
    logger level: :debug
  end

  environment :production do
    logger level: :info, formatter: :json, filter: []

    mailer do
      delivery :smtp, address: ENV.fetch('SMTP_HOST'), port: ENV.fetch('SMTP_PORT')
    end
  end
end
