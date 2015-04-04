require 'test_helper'

class TechniciansControllerTest < ActionController::TestCase
  setup do
    @technician = technicians(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:technicians)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create technician" do
    assert_difference('Technician.count') do
      post :create, technician: { employee_id: @technician.employee_id, hourly_rate: @technician.hourly_rate, level: @technician.level }
    end

    assert_redirected_to technician_path(assigns(:technician))
  end

  test "should show technician" do
    get :show, id: @technician
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @technician
    assert_response :success
  end

  test "should update technician" do
    put :update, id: @technician, technician: { employee_id: @technician.employee_id, hourly_rate: @technician.hourly_rate, level: @technician.level }
    assert_redirected_to technician_path(assigns(:technician))
  end

  test "should destroy technician" do
    assert_difference('Technician.count', -1) do
      delete :destroy, id: @technician
    end

    assert_redirected_to technicians_path
  end
end
