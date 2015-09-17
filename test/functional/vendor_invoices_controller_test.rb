require 'test_helper'

class VendorInvoicesControllerTest < ActionController::TestCase
  setup do
    @vendor_invoice = vendor_invoices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vendor_invoices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vendor_invoice" do
    assert_difference('VendorInvoice.count') do
      post :create, vendor_invoice: { date_time: @vendor_invoice.date_time, invoice_number: @vendor_invoice.invoice_number, purchase_order_id: @vendor_invoice.purchase_order_id, status: @vendor_invoice.status, vendor_id: @vendor_invoice.vendor_id }
    end

    assert_redirected_to vendor_invoice_path(assigns(:vendor_invoice))
  end

  test "should show vendor_invoice" do
    get :show, id: @vendor_invoice
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vendor_invoice
    assert_response :success
  end

  test "should update vendor_invoice" do
    put :update, id: @vendor_invoice, vendor_invoice: { date_time: @vendor_invoice.date_time, invoice_number: @vendor_invoice.invoice_number, purchase_order_id: @vendor_invoice.purchase_order_id, status: @vendor_invoice.status, vendor_id: @vendor_invoice.vendor_id }
    assert_redirected_to vendor_invoice_path(assigns(:vendor_invoice))
  end

  test "should destroy vendor_invoice" do
    assert_difference('VendorInvoice.count', -1) do
      delete :destroy, id: @vendor_invoice
    end

    assert_redirected_to vendor_invoices_path
  end
end
