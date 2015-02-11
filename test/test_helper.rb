require 'simplecov'
SimpleCov.start('rails') do
  # FIXME(uwe): Remove these filters when SimpleCov+JRuby report correct coverage
  if RUBY_PLATFORM == 'java'
  #   add_filter '/app/assets/'
    add_filter '/app/views/'
  end
  # EMXIF
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def login(login = :one)
    u = users(login)
    @request.session[:user_id] = u.id
    Thread.current[:user] = u
  end

  def assert_no_errors(symbol)
    v = assigns(symbol)
    assert v
    assert_equal [], v.errors.full_messages
  end

end
