require 'test_helper'

class ServiceJournalsEventsControllerTest < ActionController::TestCase
  setup do
    @service_journals_event = service_journals_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:service_journals_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create service_journals_event" do
    assert_difference('ServiceJournalsEvent.count') do
      post :create, service_journals_event: { name: @service_journals_event.name }
    end

    assert_redirected_to service_journals_event_path(assigns(:service_journals_event))
  end

  test "should show service_journals_event" do
    get :show, id: @service_journals_event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @service_journals_event
    assert_response :success
  end

  test "should update service_journals_event" do
    put :update, id: @service_journals_event, service_journals_event: { name: @service_journals_event.name }
    assert_redirected_to service_journals_event_path(assigns(:service_journals_event))
  end

  test "should destroy service_journals_event" do
    assert_difference('ServiceJournalsEvent.count', -1) do
      delete :destroy, id: @service_journals_event
    end

    assert_redirected_to service_journals_events_path
  end
end
