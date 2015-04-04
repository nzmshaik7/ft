require 'test_helper'

class TsBandRecallsControllerTest < ActionController::TestCase
  setup do
    @ts_band_recall = ts_band_recalls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ts_band_recalls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ts_band_recall" do
    assert_difference('TsBandRecall.count') do
      post :create, ts_band_recall: { date_completed: @ts_band_recall.date_completed, name: @ts_band_recall.name, vehicle_id: @ts_band_recall.vehicle_id }
    end

    assert_redirected_to ts_band_recall_path(assigns(:ts_band_recall))
  end

  test "should show ts_band_recall" do
    get :show, id: @ts_band_recall
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ts_band_recall
    assert_response :success
  end

  test "should update ts_band_recall" do
    put :update, id: @ts_band_recall, ts_band_recall: { date_completed: @ts_band_recall.date_completed, name: @ts_band_recall.name, vehicle_id: @ts_band_recall.vehicle_id }
    assert_redirected_to ts_band_recall_path(assigns(:ts_band_recall))
  end

  test "should destroy ts_band_recall" do
    assert_difference('TsBandRecall.count', -1) do
      delete :destroy, id: @ts_band_recall
    end

    assert_redirected_to ts_band_recalls_path
  end
end
