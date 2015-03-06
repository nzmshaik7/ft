require 'test_helper'

class MockupControllerTest < ActionController::TestCase
  test "should get internal_veh" do
    get :internal_veh
    assert_response :success
  end

  test "should get multi_veh" do
    get :multi_veh
    assert_response :success
  end

  test "should get customer_veh" do
    get :customer_veh
    assert_response :success
  end

  test "should get store" do
    get :store
    assert_response :success
  end

end
