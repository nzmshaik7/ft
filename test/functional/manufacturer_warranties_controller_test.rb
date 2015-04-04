require 'test_helper'

class ManufacturerWarrantiesControllerTest < ActionController::TestCase
  setup do
    @manufacturer_warranty = manufacturer_warranties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:manufacturer_warranties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create manufacturer_warranty" do
    assert_difference('ManufacturerWarranty.count') do
      post :create, manufacturer_warranty: { comment: @manufacturer_warranty.comment, image: @manufacturer_warranty.image, miles: @manufacturer_warranty.miles, months: @manufacturer_warranty.months, vehicle_id: @manufacturer_warranty.vehicle_id, wtype: @manufacturer_warranty.wtype }
    end

    assert_redirected_to manufacturer_warranty_path(assigns(:manufacturer_warranty))
  end

  test "should show manufacturer_warranty" do
    get :show, id: @manufacturer_warranty
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @manufacturer_warranty
    assert_response :success
  end

  test "should update manufacturer_warranty" do
    put :update, id: @manufacturer_warranty, manufacturer_warranty: { comment: @manufacturer_warranty.comment, image: @manufacturer_warranty.image, miles: @manufacturer_warranty.miles, months: @manufacturer_warranty.months, vehicle_id: @manufacturer_warranty.vehicle_id, wtype: @manufacturer_warranty.wtype }
    assert_redirected_to manufacturer_warranty_path(assigns(:manufacturer_warranty))
  end

  test "should destroy manufacturer_warranty" do
    assert_difference('ManufacturerWarranty.count', -1) do
      delete :destroy, id: @manufacturer_warranty
    end

    assert_redirected_to manufacturer_warranties_path
  end
end
