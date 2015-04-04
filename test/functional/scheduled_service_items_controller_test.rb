require 'test_helper'

class ScheduledServiceItemsControllerTest < ActionController::TestCase
  setup do
    @scheduled_service_item = scheduled_service_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scheduled_service_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scheduled_service_item" do
    assert_difference('ScheduledServiceItem.count') do
      post :create, scheduled_service_item: { other: @scheduled_service_item.other, scheduled_service_id: @scheduled_service_item.scheduled_service_id, service_description_id: @scheduled_service_item.service_description_id }
    end

    assert_redirected_to scheduled_service_item_path(assigns(:scheduled_service_item))
  end

  test "should show scheduled_service_item" do
    get :show, id: @scheduled_service_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @scheduled_service_item
    assert_response :success
  end

  test "should update scheduled_service_item" do
    put :update, id: @scheduled_service_item, scheduled_service_item: { other: @scheduled_service_item.other, scheduled_service_id: @scheduled_service_item.scheduled_service_id, service_description_id: @scheduled_service_item.service_description_id }
    assert_redirected_to scheduled_service_item_path(assigns(:scheduled_service_item))
  end

  test "should destroy scheduled_service_item" do
    assert_difference('ScheduledServiceItem.count', -1) do
      delete :destroy, id: @scheduled_service_item
    end

    assert_redirected_to scheduled_service_items_path
  end
end
