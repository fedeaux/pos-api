source 'https://rubygems.org'
ruby "2.2.3"

gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'

# Utility
gem 'dotenv-rails'
gem 'listen', '~> 3.0.5'
gem 'seedbank'
gem 'string-urlize'
gem 'uglifier', '>= 1.3.0'
gem 'oj'
gem 'wkhtmltopdf-binary'
gem 'wicked_pdf'
gem 'simplecov'

# Modeling
gem 'devise'
gem 'devise_token_auth'
gem 'omniauth'
gem 'rack-cors', :require => 'rack/cors'
gem "acts_as_singleton"

# REST
gem 'rabl-rails'
gem 'haml-rails'
gem 'sass-rails'

# Console
gem "awesome_print"
gem "pry"
gem "table_print"
gem "text-table"

group :test do
  gem 'database_cleaner', :git => 'git://github.com/bmabey/database_cleaner.git'
  gem 'factory_girl_rails'
  gem 'email_spec'
end

group :development, :test do
  gem "rspec-rails"
  gem 'byebug', platform: :mri
  gem 'log4r'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
