require 'test_helper'

class InvoiceLineItemsControllerTest < ActionController::TestCase
  setup do
    @invoice_line_item = invoice_line_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:invoice_line_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create invoice_line_item" do
    assert_difference('InvoiceLineItem.count') do
      post :create, invoice_line_item: { amount: @invoice_line_item.amount, description: @invoice_line_item.description, invoice_id: @invoice_line_item.invoice_id, line_item_purpose_id: @invoice_line_item.line_item_purpose_id, service_visit_id: @invoice_line_item.service_visit_id, vehicle_id: @invoice_line_item.vehicle_id }
    end

    assert_redirected_to invoice_line_item_path(assigns(:invoice_line_item))
  end

  test "should show invoice_line_item" do
    get :show, id: @invoice_line_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @invoice_line_item
    assert_response :success
  end

  test "should update invoice_line_item" do
    put :update, id: @invoice_line_item, invoice_line_item: { amount: @invoice_line_item.amount, description: @invoice_line_item.description, invoice_id: @invoice_line_item.invoice_id, line_item_purpose_id: @invoice_line_item.line_item_purpose_id, service_visit_id: @invoice_line_item.service_visit_id, vehicle_id: @invoice_line_item.vehicle_id }
    assert_redirected_to invoice_line_item_path(assigns(:invoice_line_item))
  end

  test "should destroy invoice_line_item" do
    assert_difference('InvoiceLineItem.count', -1) do
      delete :destroy, id: @invoice_line_item
    end

    assert_redirected_to invoice_line_items_path
  end
end
