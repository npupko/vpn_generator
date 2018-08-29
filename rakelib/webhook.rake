require 'net/http'
require "dotenv"
require 'pry'

namespace :webhook do
  desc 'set server for webhook send'
  task :set, [:url] do |_t, args|
    Dotenv.load('.env.development')
    uri = URI("https://api.telegram.org/bot#{ENV['TELEGRAM_TOKEN']}/setWebhook")
    puts params = { url: "https://#{args.url}.eu.ngrok.io/webhooks/telegram" }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    puts res.body
  end
end
