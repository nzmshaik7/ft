require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  setup do
    @customer = customers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer" do
    assert_difference('Customer.count') do
      post :create, customer: { can_text_home_phone: @customer.can_text_home_phone, can_text_mobile_phone: @customer.can_text_mobile_phone, can_text_other_phone: @customer.can_text_other_phone, can_text_work_phone: @customer.can_text_work_phone, cid: @customer.cid, city: @customer.city, date_of_birth: @customer.date_of_birth, driver_lic_image_id: @customer.driver_lic_image_id, driver_lic_num: @customer.driver_lic_num, driver_lic_state_id: @customer.driver_lic_state_id, gender: @customer.gender, home_phone: @customer.home_phone, is_aaa_member: @customer.is_aaa_member, is_web_registered: @customer.is_web_registered, joined_date: @customer.joined_date, mobile_phone: @customer.mobile_phone, other_phone: @customer.other_phone, referral_credits_earned: @customer.referral_credits_earned, referral_credits_used: @customer.referral_credits_used, referredBy_customer_id: @customer.referredBy_customer_id, referredBy_id: @customer.referredBy_id, referredBy_other_text: @customer.referredBy_other_text, signup_store_id: @customer.signup_store_id, spouse_id: @customer.spouse_id, spouse_name: @customer.spouse_name, ssn: @customer.ssn, state_id: @customer.state_id, street_addr1: @customer.street_addr1, street_addr2: @customer.street_addr2, user_id: @customer.user_id, video_testimony_url: @customer.video_testimony_url, work_phone: @customer.work_phone, written_testimony_id: @customer.written_testimony_id, zip: @customer.zip }
    end

    assert_redirected_to customer_path(assigns(:customer))
  end

  test "should show customer" do
    get :show, id: @customer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customer
    assert_response :success
  end

  test "should update customer" do
    put :update, id: @customer, customer: { can_text_home_phone: @customer.can_text_home_phone, can_text_mobile_phone: @customer.can_text_mobile_phone, can_text_other_phone: @customer.can_text_other_phone, can_text_work_phone: @customer.can_text_work_phone, cid: @customer.cid, city: @customer.city, date_of_birth: @customer.date_of_birth, driver_lic_image_id: @customer.driver_lic_image_id, driver_lic_num: @customer.driver_lic_num, driver_lic_state_id: @customer.driver_lic_state_id, gender: @customer.gender, home_phone: @customer.home_phone, is_aaa_member: @customer.is_aaa_member, is_web_registered: @customer.is_web_registered, joined_date: @customer.joined_date, mobile_phone: @customer.mobile_phone, other_phone: @customer.other_phone, referral_credits_earned: @customer.referral_credits_earned, referral_credits_used: @customer.referral_credits_used, referredBy_customer_id: @customer.referredBy_customer_id, referredBy_id: @customer.referredBy_id, referredBy_other_text: @customer.referredBy_other_text, signup_store_id: @customer.signup_store_id, spouse_id: @customer.spouse_id, spouse_name: @customer.spouse_name, ssn: @customer.ssn, state_id: @customer.state_id, street_addr1: @customer.street_addr1, street_addr2: @customer.street_addr2, user_id: @customer.user_id, video_testimony_url: @customer.video_testimony_url, work_phone: @customer.work_phone, written_testimony_id: @customer.written_testimony_id, zip: @customer.zip }
    assert_redirected_to customer_path(assigns(:customer))
  end

  test "should destroy customer" do
    assert_difference('Customer.count', -1) do
      delete :destroy, id: @customer
    end

    assert_redirected_to customers_path
  end
end
