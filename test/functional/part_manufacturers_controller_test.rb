require 'test_helper'

class PartManufacturersControllerTest < ActionController::TestCase
  setup do
    @part_manufacturer = part_manufacturers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:part_manufacturers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create part_manufacturer" do
    assert_difference('PartManufacturer.count') do
      post :create, part_manufacturer: { name: @part_manufacturer.name }
    end

    assert_redirected_to part_manufacturer_path(assigns(:part_manufacturer))
  end

  test "should show part_manufacturer" do
    get :show, id: @part_manufacturer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @part_manufacturer
    assert_response :success
  end

  test "should update part_manufacturer" do
    put :update, id: @part_manufacturer, part_manufacturer: { name: @part_manufacturer.name }
    assert_redirected_to part_manufacturer_path(assigns(:part_manufacturer))
  end

  test "should destroy part_manufacturer" do
    assert_difference('PartManufacturer.count', -1) do
      delete :destroy, id: @part_manufacturer
    end

    assert_redirected_to part_manufacturers_path
  end
end
