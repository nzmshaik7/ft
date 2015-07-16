require 'test_helper'

class TechnicianHoursControllerTest < ActionController::TestCase
  setup do
    @technician_hour = technician_hours(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:technician_hours)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create technician_hour" do
    assert_difference('TechnicianHour.count') do
      post :create, technician_hour: { labor_hours_actual: @technician_hour.labor_hours_actual, labor_hours_retail: @technician_hour.labor_hours_retail, labor_rate_actual: @technician_hour.labor_rate_actual, labor_rate_retail: @technician_hour.labor_rate_retail, service_line_item_id: @technician_hour.service_line_item_id, technician_id: @technician_hour.technician_id }
    end

    assert_redirected_to technician_hour_path(assigns(:technician_hour))
  end

  test "should show technician_hour" do
    get :show, id: @technician_hour
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @technician_hour
    assert_response :success
  end

  test "should update technician_hour" do
    put :update, id: @technician_hour, technician_hour: { labor_hours_actual: @technician_hour.labor_hours_actual, labor_hours_retail: @technician_hour.labor_hours_retail, labor_rate_actual: @technician_hour.labor_rate_actual, labor_rate_retail: @technician_hour.labor_rate_retail, service_line_item_id: @technician_hour.service_line_item_id, technician_id: @technician_hour.technician_id }
    assert_redirected_to technician_hour_path(assigns(:technician_hour))
  end

  test "should destroy technician_hour" do
    assert_difference('TechnicianHour.count', -1) do
      delete :destroy, id: @technician_hour
    end

    assert_redirected_to technician_hours_path
  end
end
