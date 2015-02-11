# encoding: utf-8
require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    login
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create user' do
    assert_difference('User.count') do
      post :create, user: {email: 'rookie@example.org', name: 'Rookie'}
      assert_no_errors :user
    end
    assert_redirected_to user_path(assigns(:user))
  end

  test 'should not create user without email' do
    assert_no_difference('User.count') do
      post :create, user: {name: 'Rookie'}
      assert_equal ['Email kan ikke være blank'],
          assigns(:user).errors.full_messages
    end
    assert_response :success
  end

  test 'should show user' do
    get :show, id: @user
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @user
    assert_response :success
  end

  test 'should update user' do
    patch :update, id: @user, user: {email: @user.email, name: @user.name, password_digest: @user.password_digest, password_salt: @user.password_salt, phone: @user.phone}
    assert_no_errors :user
    assert_redirected_to user_path(assigns(:user))
  end

  test 'should not update user with blank email' do
    patch :update, id: @user, user: {email: nil, name: @user.name, phone: @user.phone}
    assert_equal ['Email kan ikke være blank'],
        assigns(:user).errors.full_messages
    assert_response :success
  end

  test 'should destroy user' do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
