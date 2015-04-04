require 'test_helper'

class AutomaticDataLinkInfosControllerTest < ActionController::TestCase
  setup do
    @automatic_data_link_info = automatic_data_link_infos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:automatic_data_link_infos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create automatic_data_link_info" do
    assert_difference('AutomaticDataLinkInfo.count') do
      post :create, automatic_data_link_info: { data: @automatic_data_link_info.data, idate: @automatic_data_link_info.idate, serial_number: @automatic_data_link_info.serial_number, vehicle_id: @automatic_data_link_info.vehicle_id }
    end

    assert_redirected_to automatic_data_link_info_path(assigns(:automatic_data_link_info))
  end

  test "should show automatic_data_link_info" do
    get :show, id: @automatic_data_link_info
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @automatic_data_link_info
    assert_response :success
  end

  test "should update automatic_data_link_info" do
    put :update, id: @automatic_data_link_info, automatic_data_link_info: { data: @automatic_data_link_info.data, idate: @automatic_data_link_info.idate, serial_number: @automatic_data_link_info.serial_number, vehicle_id: @automatic_data_link_info.vehicle_id }
    assert_redirected_to automatic_data_link_info_path(assigns(:automatic_data_link_info))
  end

  test "should destroy automatic_data_link_info" do
    assert_difference('AutomaticDataLinkInfo.count', -1) do
      delete :destroy, id: @automatic_data_link_info
    end

    assert_redirected_to automatic_data_link_infos_path
  end
end
