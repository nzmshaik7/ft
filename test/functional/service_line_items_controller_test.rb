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
      post :create, service_line_item: { is_scheduled: @service_line_item.is_scheduled, labor_hours_actual: @service_line_item.labor_hours_actual, labor_hours_retail: @service_line_item.labor_hours_retail, labor_rate_actual: @service_line_item.labor_rate_actual, labor_rate_retail: @service_line_item.labor_rate_retail, service_description_id: @service_line_item.service_description_id, service_description_text: @service_line_item.service_description_text, service_visit_id: @service_line_item.service_visit_id, technician1_id: @service_line_item.technician1_id, technician2_id: @service_line_item.technician2_id, technician3_id: @service_line_item.technician3_id }
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
    put :update, id: @service_line_item, service_line_item: { is_scheduled: @service_line_item.is_scheduled, labor_hours_actual: @service_line_item.labor_hours_actual, labor_hours_retail: @service_line_item.labor_hours_retail, labor_rate_actual: @service_line_item.labor_rate_actual, labor_rate_retail: @service_line_item.labor_rate_retail, service_description_id: @service_line_item.service_description_id, service_description_text: @service_line_item.service_description_text, service_visit_id: @service_line_item.service_visit_id, technician1_id: @service_line_item.technician1_id, technician2_id: @service_line_item.technician2_id, technician3_id: @service_line_item.technician3_id }
    assert_redirected_to service_line_item_path(assigns(:service_line_item))
  end

  test "should destroy service_line_item" do
    assert_difference('ServiceLineItem.count', -1) do
      delete :destroy, id: @service_line_item
    end

    assert_redirected_to service_line_items_path
  end
end
