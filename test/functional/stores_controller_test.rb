require 'test_helper'

class StoresControllerTest < ActionController::TestCase
  setup do
    @store = stores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create store" do
    assert_difference('Store.count') do
      post :create, store: { break_even: @store.break_even, capacity: @store.capacity, city: @store.city, county_id: @store.county_id, manager_id: @store.manager_id, name: @store.name, number: @store.number, number_of_lifts: @store.number_of_lifts, phone: @store.phone, region_id: @store.region_id, state_id: @store.state_id, street_address: @store.street_address, zip: @store.zip }
    end

    assert_redirected_to store_path(assigns(:store))
  end

  test "should show store" do
    get :show, id: @store
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @store
    assert_response :success
  end

  test "should update store" do
    put :update, id: @store, store: { break_even: @store.break_even, capacity: @store.capacity, city: @store.city, county_id: @store.county_id, manager_id: @store.manager_id, name: @store.name, number: @store.number, number_of_lifts: @store.number_of_lifts, phone: @store.phone, region_id: @store.region_id, state_id: @store.state_id, street_address: @store.street_address, zip: @store.zip }
    assert_redirected_to store_path(assigns(:store))
  end

  test "should destroy store" do
    assert_difference('Store.count', -1) do
      delete :destroy, id: @store
    end

    assert_redirected_to stores_path
  end
end
