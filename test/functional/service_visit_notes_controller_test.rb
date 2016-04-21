require 'test_helper'

class ServiceVisitNotesControllerTest < ActionController::TestCase
  setup do
    @service_visit_note = service_visit_notes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:service_visit_notes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create service_visit_note" do
    assert_difference('ServiceVisitNote.count') do
      post :create, service_visit_note: { note: @service_visit_note.note, service_visit_id: @service_visit_note.service_visit_id, user_id: @service_visit_note.user_id }
    end

    assert_redirected_to service_visit_note_path(assigns(:service_visit_note))
  end

  test "should show service_visit_note" do
    get :show, id: @service_visit_note
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @service_visit_note
    assert_response :success
  end

  test "should update service_visit_note" do
    put :update, id: @service_visit_note, service_visit_note: { note: @service_visit_note.note, service_visit_id: @service_visit_note.service_visit_id, user_id: @service_visit_note.user_id }
    assert_redirected_to service_visit_note_path(assigns(:service_visit_note))
  end

  test "should destroy service_visit_note" do
    assert_difference('ServiceVisitNote.count', -1) do
      delete :destroy, id: @service_visit_note
    end

    assert_redirected_to service_visit_notes_path
  end
end
