require 'test_helper'

class ReferredBiesControllerTest < ActionController::TestCase
  setup do
    @referred_by = referred_bies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:referred_bies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create referred_by" do
    assert_difference('ReferredBy.count') do
      post :create, referred_by: { description: @referred_by.description, is_other: @referred_by.is_other }
    end

    assert_redirected_to referred_by_path(assigns(:referred_by))
  end

  test "should show referred_by" do
    get :show, id: @referred_by
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @referred_by
    assert_response :success
  end

  test "should update referred_by" do
    put :update, id: @referred_by, referred_by: { description: @referred_by.description, is_other: @referred_by.is_other }
    assert_redirected_to referred_by_path(assigns(:referred_by))
  end

  test "should destroy referred_by" do
    assert_difference('ReferredBy.count', -1) do
      delete :destroy, id: @referred_by
    end

    assert_redirected_to referred_bies_path
  end
end
