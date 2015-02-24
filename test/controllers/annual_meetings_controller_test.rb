require 'test_helper'

class AnnualMeetingsControllerTest < ActionController::TestCase
  setup do
    @annual_meeting = annual_meetings(:one)
    login
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:annual_meetings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create annual_meeting" do
    assert_difference('AnnualMeeting.count') do
      post :create, annual_meeting: { fee: @annual_meeting.fee, start_at: @annual_meeting.start_at }
      assert_no_errors :annual_meeting
    end

    assert_redirected_to annual_meeting_path(assigns(:annual_meeting))
  end

  test "should show annual_meeting" do
    get :show, id: @annual_meeting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @annual_meeting
    assert_response :success
  end

  test "should update annual_meeting" do
    patch :update, id: @annual_meeting, annual_meeting: { fee: @annual_meeting.fee, start_at: @annual_meeting.start_at }
    assert_redirected_to annual_meeting_path(assigns(:annual_meeting))
  end

  test "should destroy annual_meeting" do
    assert_difference('AnnualMeeting.count', -1) do
      delete :destroy, id: @annual_meeting
    end

    assert_redirected_to annual_meetings_path
  end
end
