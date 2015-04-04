require 'test_helper'

class NonMaMaintenancesControllerTest < ActionController::TestCase
  setup do
    @non_ma_maintenance = non_ma_maintenances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:non_ma_maintenances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create non_ma_maintenance" do
    assert_difference('NonMaMaintenance.count') do
      post :create, non_ma_maintenance: { document_image_id: @non_ma_maintenance.document_image_id, mdate: @non_ma_maintenance.mdate, vehicle_id: @non_ma_maintenance.vehicle_id, where: @non_ma_maintenance.where }
    end

    assert_redirected_to non_ma_maintenance_path(assigns(:non_ma_maintenance))
  end

  test "should show non_ma_maintenance" do
    get :show, id: @non_ma_maintenance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @non_ma_maintenance
    assert_response :success
  end

  test "should update non_ma_maintenance" do
    put :update, id: @non_ma_maintenance, non_ma_maintenance: { document_image_id: @non_ma_maintenance.document_image_id, mdate: @non_ma_maintenance.mdate, vehicle_id: @non_ma_maintenance.vehicle_id, where: @non_ma_maintenance.where }
    assert_redirected_to non_ma_maintenance_path(assigns(:non_ma_maintenance))
  end

  test "should destroy non_ma_maintenance" do
    assert_difference('NonMaMaintenance.count', -1) do
      delete :destroy, id: @non_ma_maintenance
    end

    assert_redirected_to non_ma_maintenances_path
  end
end
