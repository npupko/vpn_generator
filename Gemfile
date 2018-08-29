source 'https://rubygems.org'

gem 'rake'
gem 'hanami',       '~> 1.2'
gem 'hanami-model', '~> 1.2'

gem 'pg'

gem 'haml'
gem 'telegram-bot-ruby'
gem 'dry-auto_inject'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun', platforms: :ruby
  gem 'hanami-webconsole'
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
  gem 'pry'
end

group :test do
  gem 'rspec'
  gem 'hanami-fabrication'
  gem 'capybara'
end

group :production do
  # gem 'puma'
end