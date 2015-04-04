require 'test_helper'

class QualificationsControllerTest < ActionController::TestCase
  setup do
    @qualification = qualifications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:qualifications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create qualification" do
    assert_difference('Qualification.count') do
      post :create, qualification: { alignment_report_images_id: @qualification.alignment_report_images_id, cylinder_compression_spec: @qualification.cylinder_compression_spec, leakdown: @qualification.leakdown, qdate: @qualification.qdate, qual_report_images_id: @qualification.qual_report_images_id, service_visit_id: @qualification.service_visit_id, sixgas_report_images_id: @qualification.sixgas_report_images_id, spectrum_report_images_id: @qualification.spectrum_report_images_id }
    end

    assert_redirected_to qualification_path(assigns(:qualification))
  end

  test "should show qualification" do
    get :show, id: @qualification
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @qualification
    assert_response :success
  end

  test "should update qualification" do
    put :update, id: @qualification, qualification: { alignment_report_images_id: @qualification.alignment_report_images_id, cylinder_compression_spec: @qualification.cylinder_compression_spec, leakdown: @qualification.leakdown, qdate: @qualification.qdate, qual_report_images_id: @qualification.qual_report_images_id, service_visit_id: @qualification.service_visit_id, sixgas_report_images_id: @qualification.sixgas_report_images_id, spectrum_report_images_id: @qualification.spectrum_report_images_id }
    assert_redirected_to qualification_path(assigns(:qualification))
  end

  test "should destroy qualification" do
    assert_difference('Qualification.count', -1) do
      delete :destroy, id: @qualification
    end

    assert_redirected_to qualifications_path
  end
end
