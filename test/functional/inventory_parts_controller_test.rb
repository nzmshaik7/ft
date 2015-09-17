require 'test_helper'

class InventoryPartsControllerTest < ActionController::TestCase
  setup do
    @inventory_part = inventory_parts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inventory_parts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inventory_part" do
    assert_difference('InventoryPart.count') do
      post :create, inventory_part: { part_actual_price: @inventory_part.part_actual_price, part_id: @inventory_part.part_id, purchase_order_id: @inventory_part.purchase_order_id, quantity: @inventory_part.quantity }
    end

    assert_redirected_to inventory_part_path(assigns(:inventory_part))
  end

  test "should show inventory_part" do
    get :show, id: @inventory_part
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inventory_part
    assert_response :success
  end

  test "should update inventory_part" do
    put :update, id: @inventory_part, inventory_part: { part_actual_price: @inventory_part.part_actual_price, part_id: @inventory_part.part_id, purchase_order_id: @inventory_part.purchase_order_id, quantity: @inventory_part.quantity }
    assert_redirected_to inventory_part_path(assigns(:inventory_part))
  end

  test "should destroy inventory_part" do
    assert_difference('InventoryPart.count', -1) do
      delete :destroy, id: @inventory_part
    end

    assert_redirected_to inventory_parts_path
  end
end
