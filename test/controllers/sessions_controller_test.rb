require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test 'sending email should store the email in a cookie' do
    post :send_email, email: 'one@example.org'
    assert_response :redirect
    assert_redirected_to log_in_path
    assert_equal 'one@example.org', cookies[:login_email]
  end

  test 'sending email with wrong email' do
    post :send_email, email: 'invalid@example.org'
    assert_response :success
    assert_nil cookies[:login_email]
    assert_equal 'Ukjent e-postadresse', flash[:alert]
  end

  test 'stored email cookie should fill in email field in the login form' do
    cookies[:login_email] = 'one@example.org'
    get :new
    assert_response :success
    assert_equal 'one@example.org', css_select('#email')[0].attributes['value'].to_s
  end

  test 'login by link with id and hash' do
    user = users(:one)
    hash = user.password_digest.split('.').first
    get :new, id: user.id, hash: hash
    assert_response :redirect
    assert_redirected_to root_path
    assert_equal user.id, session[:user_id]
  end

  test 'login by link with id and BAD hash' do
    hash = 'BAD HASH'
    get :new, id: users(:one).id, hash: hash
    assert_response :success
    assert_equal nil, session[:user_id]
  end

  test 'login by link with BAD id' do
    get :new, id: 'BAD ID', hash: 'BAD HASH'
    assert_response :success
    assert_equal nil, session[:user_id]
  end

  test 'logout' do
    get :destroy
    assert_redirected_to root_path
    assert_equal nil, session[:user_id]
  end
end
