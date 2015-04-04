require 'test_helper'

class TireTdReadingsControllerTest < ActionController::TestCase
  setup do
    @tire_td_reading = tire_td_readings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tire_td_readings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tire_td_reading" do
    assert_difference('TireTdReading.count') do
      post :create, tire_td_reading: { depth32nds: @tire_td_reading.depth32nds, tdate: @tire_td_reading.tdate, vehicle_id: @tire_td_reading.vehicle_id }
    end

    assert_redirected_to tire_td_reading_path(assigns(:tire_td_reading))
  end

  test "should show tire_td_reading" do
    get :show, id: @tire_td_reading
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tire_td_reading
    assert_response :success
  end

  test "should update tire_td_reading" do
    put :update, id: @tire_td_reading, tire_td_reading: { depth32nds: @tire_td_reading.depth32nds, tdate: @tire_td_reading.tdate, vehicle_id: @tire_td_reading.vehicle_id }
    assert_redirected_to tire_td_reading_path(assigns(:tire_td_reading))
  end

  test "should destroy tire_td_reading" do
    assert_difference('TireTdReading.count', -1) do
      delete :destroy, id: @tire_td_reading
    end

    assert_redirected_to tire_td_readings_path
  end
end
