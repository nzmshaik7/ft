require 'test_helper'

class CodeHistoriesControllerTest < ActionController::TestCase
  setup do
    @code_history = code_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:code_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create code_history" do
    assert_difference('CodeHistory.count') do
      post :create, code_history: { cdate: @code_history.cdate, code: @code_history.code, vehicle_id: @code_history.vehicle_id }
    end

    assert_redirected_to code_history_path(assigns(:code_history))
  end

  test "should show code_history" do
    get :show, id: @code_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @code_history
    assert_response :success
  end

  test "should update code_history" do
    put :update, id: @code_history, code_history: { cdate: @code_history.cdate, code: @code_history.code, vehicle_id: @code_history.vehicle_id }
    assert_redirected_to code_history_path(assigns(:code_history))
  end

  test "should destroy code_history" do
    assert_difference('CodeHistory.count', -1) do
      delete :destroy, id: @code_history
    end

    assert_redirected_to code_histories_path
  end
end
