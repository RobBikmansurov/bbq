source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '~> 6.0.3'
gem 'puma', '~> 5.0'
gem 'webpacker', '~> 4.0'

gem 'devise'
gem 'devise-i18n'
gem 'rails-i18n', '~> 6.0.0'

gem 'carrierwave', '~> 2.0'
gem 'rmagick'
gem 'fog-aws'
gem 'pundit'
gem 'resque', '~> 2.0'

group :development, :test do
  gem 'sqlite3'
  gem 'byebug'
  gem 'rspec-rails', '~> 4.0.1'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'rails-controller-testing'
  gem 'capybara'
  gem 'launchy' # save_and_open_page in features spec
  gem 'letter_opener'
  gem 'database_cleaner-active_record'
end

group :development do
  gem 'capistrano', '~> 3.14.1', require: false
  gem 'capistrano-rails', '~> 1.6', require: false
  gem 'capistrano-bundler', '~> 2.0', require: false
  gem 'capistrano-rbenv', '~> 2.2', require: false
  # gem 'capistrano3-puma'
  gem 'capistrano-passenger', require: false
  gem 'capistrano-resque', '~> 0.2.3', require: false
  gem 'ed25519', '~> 1.2'
  gem 'bcrypt_pbkdf', '~> 1'

  gem 'web-console', '>= 3.3.0'
end

group :production do
  gem 'pg'
end
