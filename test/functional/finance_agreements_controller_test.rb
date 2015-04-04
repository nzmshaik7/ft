require 'test_helper'

class FinanceAgreementsControllerTest < ActionController::TestCase
  setup do
    @finance_agreement = finance_agreements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:finance_agreements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create finance_agreement" do
    assert_difference('FinanceAgreement.count') do
      post :create, finance_agreement: { agreement_image_id: @finance_agreement.agreement_image_id, customer_id: @finance_agreement.customer_id, end_date: @finance_agreement.end_date, finance_fee: @finance_agreement.finance_fee, missed_payment_fee: @finance_agreement.missed_payment_fee, monthly_payment_amount: @finance_agreement.monthly_payment_amount, start_date: @finance_agreement.start_date, title_image_id: @finance_agreement.title_image_id, total_principal: @finance_agreement.total_principal }
    end

    assert_redirected_to finance_agreement_path(assigns(:finance_agreement))
  end

  test "should show finance_agreement" do
    get :show, id: @finance_agreement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @finance_agreement
    assert_response :success
  end

  test "should update finance_agreement" do
    put :update, id: @finance_agreement, finance_agreement: { agreement_image_id: @finance_agreement.agreement_image_id, customer_id: @finance_agreement.customer_id, end_date: @finance_agreement.end_date, finance_fee: @finance_agreement.finance_fee, missed_payment_fee: @finance_agreement.missed_payment_fee, monthly_payment_amount: @finance_agreement.monthly_payment_amount, start_date: @finance_agreement.start_date, title_image_id: @finance_agreement.title_image_id, total_principal: @finance_agreement.total_principal }
    assert_redirected_to finance_agreement_path(assigns(:finance_agreement))
  end

  test "should destroy finance_agreement" do
    assert_difference('FinanceAgreement.count', -1) do
      delete :destroy, id: @finance_agreement
    end

    assert_redirected_to finance_agreements_path
  end
end
