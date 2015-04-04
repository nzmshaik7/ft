require 'test_helper'

class ServiceSchedulesControllerTest < ActionController::TestCase
  setup do
    @service_schedule = service_schedules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:service_schedules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create service_schedule" do
    assert_difference('ServiceSchedule.count') do
      post :create, service_schedule: { image_id: @service_schedule.image_id }
    end

    assert_redirected_to service_schedule_path(assigns(:service_schedule))
  end

  test "should show service_schedule" do
    get :show, id: @service_schedule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @service_schedule
    assert_response :success
  end

  test "should update service_schedule" do
    put :update, id: @service_schedule, service_schedule: { image_id: @service_schedule.image_id }
    assert_redirected_to service_schedule_path(assigns(:service_schedule))
  end

  test "should destroy service_schedule" do
    assert_difference('ServiceSchedule.count', -1) do
      delete :destroy, id: @service_schedule
    end

    assert_redirected_to service_schedules_path
  end
end
