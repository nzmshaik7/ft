require 'test_helper'

class WrittenTestimoniesControllerTest < ActionController::TestCase
  setup do
    @written_testimony = written_testimonies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:written_testimonies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create written_testimony" do
    assert_difference('WrittenTestimony.count') do
      post :create, written_testimony: { user_text: @written_testimony.user_text }
    end

    assert_redirected_to written_testimony_path(assigns(:written_testimony))
  end

  test "should show written_testimony" do
    get :show, id: @written_testimony
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @written_testimony
    assert_response :success
  end

  test "should update written_testimony" do
    put :update, id: @written_testimony, written_testimony: { user_text: @written_testimony.user_text }
    assert_redirected_to written_testimony_path(assigns(:written_testimony))
  end

  test "should destroy written_testimony" do
    assert_difference('WrittenTestimony.count', -1) do
      delete :destroy, id: @written_testimony
    end

    assert_redirected_to written_testimonies_path
  end
end
