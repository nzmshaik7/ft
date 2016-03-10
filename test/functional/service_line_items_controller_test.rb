require 'test_helper'

class ServiceLineItemsControllerTest < ActionController::TestCase
  setup do
    @service_line_item = service_line_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:service_line_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create service_line_item" do
    assert_difference('ServiceLineItem.count') do
      post :create, service_line_item: { service_description_id: @service_line_item.service_description_id, service_description_text: @service_line_item.service_description_text, service_visit_id: @service_line_item.service_visit_id, }
    end

    assert_redirected_to service_line_item_path(assigns(:service_line_item))
  end

  test "should show service_line_item" do
    get :show, id: @service_line_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @service_line_item
    assert_response :success
  end

  test "should update service_line_item" do
    put :update, id: @service_line_item, service_line_item: { service_description_id: @service_line_item.service_description_id, service_description_text: @service_line_item.service_description_text, service_visit_id: @service_line_item.service_visit_id, }
    assert_redirected_to service_line_item_path(assigns(:service_line_item))
  end

  test "should destroy service_line_item" do
    assert_difference('ServiceLineItem.count', -1) do
      delete :destroy, id: @service_line_item
    end

    assert_redirected_to service_line_items_path
  end
end
