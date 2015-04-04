require 'test_helper'

class BgSystemsControllerTest < ActionController::TestCase
  setup do
    @bg_system = bg_systems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bg_systems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bg_system" do
    assert_difference('BgSystem.count') do
      post :create, bg_system: { name: @bg_system.name }
    end

    assert_redirected_to bg_system_path(assigns(:bg_system))
  end

  test "should show bg_system" do
    get :show, id: @bg_system
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bg_system
    assert_response :success
  end

  test "should update bg_system" do
    put :update, id: @bg_system, bg_system: { name: @bg_system.name }
    assert_redirected_to bg_system_path(assigns(:bg_system))
  end

  test "should destroy bg_system" do
    assert_difference('BgSystem.count', -1) do
      delete :destroy, id: @bg_system
    end

    assert_redirected_to bg_systems_path
  end
end
