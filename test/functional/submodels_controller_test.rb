require 'test_helper'

class SubmodelsControllerTest < ActionController::TestCase
  setup do
    @submodel = submodels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:submodels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create submodel" do
    assert_difference('Submodel.count') do
      post :create, submodel: { make_id: @submodel.make_id, name: @submodel.name }
    end

    assert_redirected_to submodel_path(assigns(:submodel))
  end

  test "should show submodel" do
    get :show, id: @submodel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @submodel
    assert_response :success
  end

  test "should update submodel" do
    put :update, id: @submodel, submodel: { make_id: @submodel.make_id, name: @submodel.name }
    assert_redirected_to submodel_path(assigns(:submodel))
  end

  test "should destroy submodel" do
    assert_difference('Submodel.count', -1) do
      delete :destroy, id: @submodel
    end

    assert_redirected_to submodels_path
  end
end
