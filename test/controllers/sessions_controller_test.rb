require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test 'sending email should store the email in a cookie' do
    post :send_email, email: 'one@example.org'
    assert_response :redirect
    assert_redirected_to log_in_path
    assert_equal 'one@example.org', cookies[:login_email]
  end

  test 'stored email cookie should fill in email field in the login form' do
    cookies[:login_email] = 'one@example.org'
    get :new
    assert_response :success
    assert_equal 'one@example.org', css_select('#email')[0].attributes['value']
  end

end
