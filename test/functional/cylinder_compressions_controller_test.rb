require 'test_helper'

class CylinderCompressionsControllerTest < ActionController::TestCase
  setup do
    @cylinder_compression = cylinder_compressions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cylinder_compressions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cylinder_compression" do
    assert_difference('CylinderCompression.count') do
      post :create, cylinder_compression: { cyl_num: @cylinder_compression.cyl_num, psi: @cylinder_compression.psi, qualification_id: @cylinder_compression.qualification_id }
    end

    assert_redirected_to cylinder_compression_path(assigns(:cylinder_compression))
  end

  test "should show cylinder_compression" do
    get :show, id: @cylinder_compression
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cylinder_compression
    assert_response :success
  end

  test "should update cylinder_compression" do
    put :update, id: @cylinder_compression, cylinder_compression: { cyl_num: @cylinder_compression.cyl_num, psi: @cylinder_compression.psi, qualification_id: @cylinder_compression.qualification_id }
    assert_redirected_to cylinder_compression_path(assigns(:cylinder_compression))
  end

  test "should destroy cylinder_compression" do
    assert_difference('CylinderCompression.count', -1) do
      delete :destroy, id: @cylinder_compression
    end

    assert_redirected_to cylinder_compressions_path
  end
end
