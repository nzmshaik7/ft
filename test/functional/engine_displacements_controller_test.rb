require 'test_helper'

class EngineDisplacementsControllerTest < ActionController::TestCase
  setup do
    @engine_displacement = engine_displacements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:engine_displacements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create engine_displacement" do
    assert_difference('EngineDisplacement.count') do
      post :create, engine_displacement: { name: @engine_displacement.name }
    end

    assert_redirected_to engine_displacement_path(assigns(:engine_displacement))
  end

  test "should show engine_displacement" do
    get :show, id: @engine_displacement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @engine_displacement
    assert_response :success
  end

  test "should update engine_displacement" do
    put :update, id: @engine_displacement, engine_displacement: { name: @engine_displacement.name }
    assert_redirected_to engine_displacement_path(assigns(:engine_displacement))
  end

  test "should destroy engine_displacement" do
    assert_difference('EngineDisplacement.count', -1) do
      delete :destroy, id: @engine_displacement
    end

    assert_redirected_to engine_displacements_path
  end
end
