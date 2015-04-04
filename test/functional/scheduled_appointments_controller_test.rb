require 'test_helper'

class ScheduledAppointmentsControllerTest < ActionController::TestCase
  setup do
    @scheduled_appointment = scheduled_appointments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scheduled_appointments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scheduled_appointment" do
    assert_difference('ScheduledAppointment.count') do
      post :create, scheduled_appointment: { actual_date_time: @scheduled_appointment.actual_date_time, date_time: @scheduled_appointment.date_time, purpose: @scheduled_appointment.purpose, status: @scheduled_appointment.status, store_id: @scheduled_appointment.store_id, vehicle_id: @scheduled_appointment.vehicle_id }
    end

    assert_redirected_to scheduled_appointment_path(assigns(:scheduled_appointment))
  end

  test "should show scheduled_appointment" do
    get :show, id: @scheduled_appointment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @scheduled_appointment
    assert_response :success
  end

  test "should update scheduled_appointment" do
    put :update, id: @scheduled_appointment, scheduled_appointment: { actual_date_time: @scheduled_appointment.actual_date_time, date_time: @scheduled_appointment.date_time, purpose: @scheduled_appointment.purpose, status: @scheduled_appointment.status, store_id: @scheduled_appointment.store_id, vehicle_id: @scheduled_appointment.vehicle_id }
    assert_redirected_to scheduled_appointment_path(assigns(:scheduled_appointment))
  end

  test "should destroy scheduled_appointment" do
    assert_difference('ScheduledAppointment.count', -1) do
      delete :destroy, id: @scheduled_appointment
    end

    assert_redirected_to scheduled_appointments_path
  end
end
