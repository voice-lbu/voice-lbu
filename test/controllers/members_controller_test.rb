require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  setup do
    @member = members(:one)
    login
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:members)
  end

  test 'should get active' do
    get :active
    assert_response :success
    assert_not_nil assigns(:members)
  end

  test 'should get left' do
    get :left
    assert_response :success
    assert_not_nil assigns(:members)
  end

  test 'should get invoice' do
    get :faktura, id: users(:one).id
    assert_response :success
    assert_not_nil assigns(:member)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create member' do
    assert_difference('Member.count') do
      post :create, member: {address: @member.address, birthdate: @member.birthdate, email: @member.email, female: @member.female, guardian_1: @member.guardian_1, guardian_1_email: @member.guardian_1_email, guardian_2: @member.guardian_2, guardian_2_email: @member.guardian_2_email, joined_on: @member.joined_on, left_on: @member.left_on, mobile: @member.mobile, name: @member.name, post_office: @member.post_office, postal_code: @member.postal_code}
    end

    assert_redirected_to edit_member_path(assigns(:member))
  end

  test 'should not create member without name' do
    post :create, member: {address: @member.address,
            birthdate: @member.birthdate, email: @member.email,
            female: @member.female,
            guardian_1: @member.guardian_1,
            guardian_1_email: @member.guardian_1_email,
            guardian_2: @member.guardian_2,
            guardian_2_email: @member.guardian_2_email,
            joined_on: @member.joined_on, left_on: @member.left_on,
            mobile: @member.mobile,
            post_office: @member.post_office,
            postal_code: @member.postal_code,
        }
    assert_response :success
  end

  test 'should show member' do
    get :show, id: @member
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @member
    assert_response :success
  end

  test 'should update member' do
    patch :update, id: @member, member: {address: @member.address, birthdate: @member.birthdate, email: @member.email, female: @member.female, guardian_1: @member.guardian_1, guardian_1_email: @member.guardian_1_email, guardian_2: @member.guardian_2, guardian_2_email: @member.guardian_2_email, joined_on: @member.joined_on, left_on: @member.left_on, mobile: @member.mobile, name: @member.name, post_office: @member.post_office, postal_code: @member.postal_code}
    assert_redirected_to edit_member_path(assigns(:member))
  end

  test 'should not update member without name' do
    patch :update, id: @member, member: {address: @member.address,
            birthdate: @member.birthdate, email: @member.email,
            female: @member.female, guardian_1: @member.guardian_1,
            guardian_1_email: @member.guardian_1_email,
            guardian_2: @member.guardian_2,
            guardian_2_email: @member.guardian_2_email,
            joined_on: @member.joined_on, left_on: @member.left_on,
            mobile: @member.mobile, name: nil, post_office: @member.post_office,
            postal_code: @member.postal_code,
        }
    assert_response :success
  end

  # test "should destroy member" do
  #   assert_difference('Member.count', -1) do
  #     delete :destroy, id: @member
  #   end
  #
  #   assert_redirected_to members_path
  # end
end
