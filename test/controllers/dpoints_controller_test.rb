require 'test_helper'

class DpointsControllerTest < ActionController::TestCase
  setup do
    @dpoint = dpoints(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dpoints)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dpoint" do
    assert_difference('Dpoint.count') do
      post :create, dpoint: { app_name: @dpoint.app_name, pipeline_id: @dpoint.pipeline_id, pipeline_instance_id: @dpoint.pipeline_instance_id, sabre_phase: @dpoint.sabre_phase, tags: @dpoint.tags, task: @dpoint.task, timestamp: @dpoint.timestamp, trended_metrics: @dpoint.trended_metrics }
    end

    assert_redirected_to dpoint_path(assigns(:dpoint))
  end

  test "should show dpoint" do
    get :show, id: @dpoint
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dpoint
    assert_response :success
  end

  test "should update dpoint" do
    patch :update, id: @dpoint, dpoint: { app_name: @dpoint.app_name, pipeline_id: @dpoint.pipeline_id, pipeline_instance_id: @dpoint.pipeline_instance_id, sabre_phase: @dpoint.sabre_phase, tags: @dpoint.tags, task: @dpoint.task, timestamp: @dpoint.timestamp, trended_metrics: @dpoint.trended_metrics }
    assert_redirected_to dpoint_path(assigns(:dpoint))
  end

  test "should destroy dpoint" do
    assert_difference('Dpoint.count', -1) do
      delete :destroy, id: @dpoint
    end

    assert_redirected_to dpoints_path
  end
end
