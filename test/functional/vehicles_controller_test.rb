require 'test_helper'

class VehiclesControllerTest < ActionController::TestCase
  setup do
    @vehicle = vehicles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vehicles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vehicle" do
    assert_difference('Vehicle.count') do
      post :create, vehicle: { bg_compliant: @vehicle.bg_compliant, carfax_copy_at_qual: @vehicle.carfax_copy_at_qual, carfax_url: @vehicle.carfax_url, color_id: @vehicle.color_id, comments: @vehicle.comments, consumer_reports_url: @vehicle.consumer_reports_url, contract_id: @vehicle.contract_id, convertible: @vehicle.convertible, country_of_manufacture_id: @vehicle.country_of_manufacture_id, current_kbb: @vehicle.current_kbb, customer_id: @vehicle.customer_id, date_of_manufacture: @vehicle.date_of_manufacture, door_plate_image_id: @vehicle.door_plate_image_id, doors: @vehicle.doors, engine_cyl: @vehicle.engine_cyl, engine_displacement_id: @vehicle.engine_displacement_id, insurance_company_id: @vehicle.insurance_company_id, insurance_image_id: @vehicle.insurance_image_id, insurance_policy_number: @vehicle.insurance_policy_number, kbb_on_qual: @vehicle.kbb_on_qual, license_plate: @vehicle.license_plate, license_plate_state_id: @vehicle.license_plate_state_id, make_id: @vehicle.make_id, mileage: @vehicle.mileage, model_id: @vehicle.model_id, mpg30after_initial: @vehicle.mpg30after_initial, msrp: @vehicle.msrp, photos_image_id: @vehicle.photos_image_id, qualification_id: @vehicle.qualification_id, service_schedule_id: @vehicle.service_schedule_id, submodel_id: @vehicle.submodel_id, vin: @vehicle.vin, vin_decoded: @vehicle.vin_decoded, wheel_drive_id: @vehicle.wheel_drive_id }
    end

    assert_redirected_to vehicle_path(assigns(:vehicle))
  end

  test "should show vehicle" do
    get :show, id: @vehicle
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vehicle
    assert_response :success
  end

  test "should update vehicle" do
    put :update, id: @vehicle, vehicle: { bg_compliant: @vehicle.bg_compliant, carfax_copy_at_qual: @vehicle.carfax_copy_at_qual, carfax_url: @vehicle.carfax_url, color_id: @vehicle.color_id, comments: @vehicle.comments, consumer_reports_url: @vehicle.consumer_reports_url, contract_id: @vehicle.contract_id, convertible: @vehicle.convertible, country_of_manufacture_id: @vehicle.country_of_manufacture_id, current_kbb: @vehicle.current_kbb, customer_id: @vehicle.customer_id, date_of_manufacture: @vehicle.date_of_manufacture, door_plate_image_id: @vehicle.door_plate_image_id, doors: @vehicle.doors, engine_cyl: @vehicle.engine_cyl, engine_displacement_id: @vehicle.engine_displacement_id, insurance_company_id: @vehicle.insurance_company_id, insurance_image_id: @vehicle.insurance_image_id, insurance_policy_number: @vehicle.insurance_policy_number, kbb_on_qual: @vehicle.kbb_on_qual, license_plate: @vehicle.license_plate, license_plate_state_id: @vehicle.license_plate_state_id, make_id: @vehicle.make_id, mileage: @vehicle.mileage, model_id: @vehicle.model_id, mpg30after_initial: @vehicle.mpg30after_initial, msrp: @vehicle.msrp, photos_image_id: @vehicle.photos_image_id, qualification_id: @vehicle.qualification_id, service_schedule_id: @vehicle.service_schedule_id, submodel_id: @vehicle.submodel_id, vin: @vehicle.vin, vin_decoded: @vehicle.vin_decoded, wheel_drive_id: @vehicle.wheel_drive_id }
    assert_redirected_to vehicle_path(assigns(:vehicle))
  end

  test "should destroy vehicle" do
    assert_difference('Vehicle.count', -1) do
      delete :destroy, id: @vehicle
    end

    assert_redirected_to vehicles_path
  end
end
