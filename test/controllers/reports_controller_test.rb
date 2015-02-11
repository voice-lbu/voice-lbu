require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  setup { login }

  def test_index
    get :index
    assert_response :success
  end
end
