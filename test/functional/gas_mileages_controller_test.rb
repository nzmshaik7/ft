require 'test_helper'

class GasMileagesControllerTest < ActionController::TestCase
  setup do
    @gas_mileage = gas_mileages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gas_mileages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gas_mileage" do
    assert_difference('GasMileage.count') do
      post :create, gas_mileage: { mdate: @gas_mileage.mdate, mileage: @gas_mileage.mileage, vehicle_id: @gas_mileage.vehicle_id }
    end

    assert_redirected_to gas_mileage_path(assigns(:gas_mileage))
  end

  test "should show gas_mileage" do
    get :show, id: @gas_mileage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gas_mileage
    assert_response :success
  end

  test "should update gas_mileage" do
    put :update, id: @gas_mileage, gas_mileage: { mdate: @gas_mileage.mdate, mileage: @gas_mileage.mileage, vehicle_id: @gas_mileage.vehicle_id }
    assert_redirected_to gas_mileage_path(assigns(:gas_mileage))
  end

  test "should destroy gas_mileage" do
    assert_difference('GasMileage.count', -1) do
      delete :destroy, id: @gas_mileage
    end

    assert_redirected_to gas_mileages_path
  end
end
