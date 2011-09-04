require 'test_helper'

class LogEntriesControllerTest < ActionController::TestCase
  setup do
    @log_entry = log_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:log_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create log_entry" do
    assert_difference('LogEntry.count') do
      post :create, :log_entry => @log_entry.attributes
    end

    assert_redirected_to log_entry_path(assigns(:log_entry))
  end

  test "should show log_entry" do
    get :show, :id => @log_entry.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @log_entry.to_param
    assert_response :success
  end

  test "should update log_entry" do
    put :update, :id => @log_entry.to_param, :log_entry => @log_entry.attributes
    assert_redirected_to log_entry_path(assigns(:log_entry))
  end

  test "should destroy log_entry" do
    assert_difference('LogEntry.count', -1) do
      delete :destroy, :id => @log_entry.to_param
    end

    assert_redirected_to log_entries_path
  end
end
