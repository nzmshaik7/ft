require 'test_helper'

class TopControllerTest < ActionController::TestCase
  test "should get db" do
    get :db
    assert_response :success
  end

end
