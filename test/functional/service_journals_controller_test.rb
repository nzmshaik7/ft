require 'test_helper'

class ServiceJournalsControllerTest < ActionController::TestCase
  setup do
    @service_journal = service_journals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:service_journals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create service_journal" do
    assert_difference('ServiceJournal.count') do
      post :create, service_journal: { date_time: @service_journal.date_time, event_id: @service_journal.event_id, service_visit_id: @service_journal.service_visit_id }
    end

    assert_redirected_to service_journal_path(assigns(:service_journal))
  end

  test "should show service_journal" do
    get :show, id: @service_journal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @service_journal
    assert_response :success
  end

  test "should update service_journal" do
    put :update, id: @service_journal, service_journal: { date_time: @service_journal.date_time, event_id: @service_journal.event_id, service_visit_id: @service_journal.service_visit_id }
    assert_redirected_to service_journal_path(assigns(:service_journal))
  end

  test "should destroy service_journal" do
    assert_difference('ServiceJournal.count', -1) do
      delete :destroy, id: @service_journal
    end

    assert_redirected_to service_journals_path
  end
end
