require 'test_helper'

class UpgradeTypesControllerTest < ActionController::TestCase
  setup do
    @upgrade_type = upgrade_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:upgrade_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create upgrade_type" do
    assert_difference('UpgradeType.count') do
      post :create, upgrade_type: { cost: @upgrade_type.cost, name: @upgrade_type.name }
    end

    assert_redirected_to upgrade_type_path(assigns(:upgrade_type))
  end

  test "should show upgrade_type" do
    get :show, id: @upgrade_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @upgrade_type
    assert_response :success
  end

  test "should update upgrade_type" do
    put :update, id: @upgrade_type, upgrade_type: { cost: @upgrade_type.cost, name: @upgrade_type.name }
    assert_redirected_to upgrade_type_path(assigns(:upgrade_type))
  end

  test "should destroy upgrade_type" do
    assert_difference('UpgradeType.count', -1) do
      delete :destroy, id: @upgrade_type
    end

    assert_redirected_to upgrade_types_path
  end
end
