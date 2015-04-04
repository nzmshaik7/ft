require 'test_helper'

class BgSystemCoveredsControllerTest < ActionController::TestCase
  setup do
    @bg_system_covered = bg_system_covereds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bg_system_covereds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bg_system_covered" do
    assert_difference('BgSystemCovered.count') do
      post :create, bg_system_covered: { coverage: @bg_system_covered.coverage, system_id: @bg_system_covered.system_id, vehicle_id: @bg_system_covered.vehicle_id }
    end

    assert_redirected_to bg_system_covered_path(assigns(:bg_system_covered))
  end

  test "should show bg_system_covered" do
    get :show, id: @bg_system_covered
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bg_system_covered
    assert_response :success
  end

  test "should update bg_system_covered" do
    put :update, id: @bg_system_covered, bg_system_covered: { coverage: @bg_system_covered.coverage, system_id: @bg_system_covered.system_id, vehicle_id: @bg_system_covered.vehicle_id }
    assert_redirected_to bg_system_covered_path(assigns(:bg_system_covered))
  end

  test "should destroy bg_system_covered" do
    assert_difference('BgSystemCovered.count', -1) do
      delete :destroy, id: @bg_system_covered
    end

    assert_redirected_to bg_system_covereds_path
  end
end
