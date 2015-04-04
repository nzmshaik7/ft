require 'test_helper'

class LineItemPurposesControllerTest < ActionController::TestCase
  setup do
    @line_item_purpose = line_item_purposes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_item_purposes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_item_purpose" do
    assert_difference('LineItemPurpose.count') do
      post :create, line_item_purpose: { name: @line_item_purpose.name }
    end

    assert_redirected_to line_item_purpose_path(assigns(:line_item_purpose))
  end

  test "should show line_item_purpose" do
    get :show, id: @line_item_purpose
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @line_item_purpose
    assert_response :success
  end

  test "should update line_item_purpose" do
    put :update, id: @line_item_purpose, line_item_purpose: { name: @line_item_purpose.name }
    assert_redirected_to line_item_purpose_path(assigns(:line_item_purpose))
  end

  test "should destroy line_item_purpose" do
    assert_difference('LineItemPurpose.count', -1) do
      delete :destroy, id: @line_item_purpose
    end

    assert_redirected_to line_item_purposes_path
  end
end
