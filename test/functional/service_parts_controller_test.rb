require 'test_helper'

class ServicePartsControllerTest < ActionController::TestCase
  setup do
    @service_part = service_parts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:service_parts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create service_part" do
    assert_difference('ServicePart.count') do
      post :create, service_part: { part_actual_price: @service_part.part_actual_price, part_id: @service_part.part_id, part_retail_price: @service_part.part_retail_price, service_line_item_id: @service_part.service_line_item_id }
    end

    assert_redirected_to service_part_path(assigns(:service_part))
  end

  test "should show service_part" do
    get :show, id: @service_part
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @service_part
    assert_response :success
  end

  test "should update service_part" do
    put :update, id: @service_part, service_part: { part_actual_price: @service_part.part_actual_price, part_id: @service_part.part_id, part_retail_price: @service_part.part_retail_price, service_line_item_id: @service_part.service_line_item_id }
    assert_redirected_to service_part_path(assigns(:service_part))
  end

  test "should destroy service_part" do
    assert_difference('ServicePart.count', -1) do
      delete :destroy, id: @service_part
    end

    assert_redirected_to service_parts_path
  end
end
