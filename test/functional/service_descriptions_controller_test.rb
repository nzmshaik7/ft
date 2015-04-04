require 'test_helper'

class ServiceDescriptionsControllerTest < ActionController::TestCase
  setup do
    @service_description = service_descriptions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:service_descriptions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create service_description" do
    assert_difference('ServiceDescription.count') do
      post :create, service_description: { labor_hours_retail: @service_description.labor_hours_retail, labor_rate_retail: @service_description.labor_rate_retail, name: @service_description.name, service_category_id: @service_description.service_category_id }
    end

    assert_redirected_to service_description_path(assigns(:service_description))
  end

  test "should show service_description" do
    get :show, id: @service_description
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @service_description
    assert_response :success
  end

  test "should update service_description" do
    put :update, id: @service_description, service_description: { labor_hours_retail: @service_description.labor_hours_retail, labor_rate_retail: @service_description.labor_rate_retail, name: @service_description.name, service_category_id: @service_description.service_category_id }
    assert_redirected_to service_description_path(assigns(:service_description))
  end

  test "should destroy service_description" do
    assert_difference('ServiceDescription.count', -1) do
      delete :destroy, id: @service_description
    end

    assert_redirected_to service_descriptions_path
  end
end
