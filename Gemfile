source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
gem 'puma', '~> 4.1'
gem 'webpacker'

gem 'devise'
gem 'devise-i18n'
gem 'rails-i18n', '~> 6.0.0'
gem 'russian', '~> 0.6.0'

group :development, :test do
  gem 'sqlite3', '~> 1.4'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen'
  gem 'web-console', '>= 3.3.0'
end

group :production do
  gem 'pg'
end
