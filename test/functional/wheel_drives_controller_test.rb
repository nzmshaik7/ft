require 'test_helper'

class WheelDrivesControllerTest < ActionController::TestCase
  setup do
    @wheel_drife = wheel_drives(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wheel_drives)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wheel_drife" do
    assert_difference('WheelDrive.count') do
      post :create, wheel_drife: { name: @wheel_drife.name }
    end

    assert_redirected_to wheel_drife_path(assigns(:wheel_drife))
  end

  test "should show wheel_drife" do
    get :show, id: @wheel_drife
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wheel_drife
    assert_response :success
  end

  test "should update wheel_drife" do
    put :update, id: @wheel_drife, wheel_drife: { name: @wheel_drife.name }
    assert_redirected_to wheel_drife_path(assigns(:wheel_drife))
  end

  test "should destroy wheel_drife" do
    assert_difference('WheelDrive.count', -1) do
      delete :destroy, id: @wheel_drife
    end

    assert_redirected_to wheel_drives_path
  end
end
