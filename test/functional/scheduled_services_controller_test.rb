require 'test_helper'

class ScheduledServicesControllerTest < ActionController::TestCase
  setup do
    @scheduled_service = scheduled_services(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scheduled_services)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scheduled_service" do
    assert_difference('ScheduledService.count') do
      post :create, scheduled_service: { mileage: @scheduled_service.mileage, sdate: @scheduled_service.sdate, service_schedule_id: @scheduled_service.service_schedule_id }
    end

    assert_redirected_to scheduled_service_path(assigns(:scheduled_service))
  end

  test "should show scheduled_service" do
    get :show, id: @scheduled_service
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @scheduled_service
    assert_response :success
  end

  test "should update scheduled_service" do
    put :update, id: @scheduled_service, scheduled_service: { mileage: @scheduled_service.mileage, sdate: @scheduled_service.sdate, service_schedule_id: @scheduled_service.service_schedule_id }
    assert_redirected_to scheduled_service_path(assigns(:scheduled_service))
  end

  test "should destroy scheduled_service" do
    assert_difference('ScheduledService.count', -1) do
      delete :destroy, id: @scheduled_service
    end

    assert_redirected_to scheduled_services_path
  end
end
