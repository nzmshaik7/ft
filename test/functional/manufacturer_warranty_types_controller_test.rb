require 'test_helper'

class ManufacturerWarrantyTypesControllerTest < ActionController::TestCase
  setup do
    @manufacturer_warranty_type = manufacturer_warranty_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:manufacturer_warranty_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create manufacturer_warranty_type" do
    assert_difference('ManufacturerWarrantyType.count') do
      post :create, manufacturer_warranty_type: { name: @manufacturer_warranty_type.name }
    end

    assert_redirected_to manufacturer_warranty_type_path(assigns(:manufacturer_warranty_type))
  end

  test "should show manufacturer_warranty_type" do
    get :show, id: @manufacturer_warranty_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @manufacturer_warranty_type
    assert_response :success
  end

  test "should update manufacturer_warranty_type" do
    put :update, id: @manufacturer_warranty_type, manufacturer_warranty_type: { name: @manufacturer_warranty_type.name }
    assert_redirected_to manufacturer_warranty_type_path(assigns(:manufacturer_warranty_type))
  end

  test "should destroy manufacturer_warranty_type" do
    assert_difference('ManufacturerWarrantyType.count', -1) do
      delete :destroy, id: @manufacturer_warranty_type
    end

    assert_redirected_to manufacturer_warranty_types_path
  end
end
