source 'https://rubygems.org'

ruby File.read("#{__dir__}/.ruby-version")[5..-1]

gem 'rails', '~>4.2.0'

platform :jruby do
  gem 'activerecord-jdbcpostgresql-adapter'
  gem 'therubyrhino'
end

platform :ruby do
  gem 'pg', '<1'
  gem 'therubyracer'
end

gem 'bcrypt'
gem 'bootstrap-sass'
gem 'bootstrap3-datetimepicker-rails'
gem 'coffee-rails'
gem 'exception_notification'
gem 'jbuilder'
gem 'jquery-rails'
gem 'momentjs-rails'
gem 'nprogress-rails'
gem 'prawn'
gem 'prawn-table'
gem 'puma'
gem 'rack-mini-profiler'
gem 'rails-i18n'
gem 'rails_12factor'
gem 'rufus-scheduler'
gem 'sass-rails'
gem 'schema_plus'
gem 'turbolinks'
gem 'uglifier'

group :test do
  gem 'minitest-reporters'
  gem 'simplecov'
end
