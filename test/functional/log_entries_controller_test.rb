require 'test_helper'

class LogEntriesControllerTest < ActionController::TestCase
  setup do
    @cache = fruit_caches(:guelph_cache)
    @log_entry = log_entries(:one)
    user = users(:vfilby)
    session[:user_id] = user.id
  end

  test "should get index" do
    get :index, :fruit_cache_id => @cache.id
    assert_redirected_to fruit_cache_path(@cache)
  end

  test "should get new" do
    get :new, :fruit_cache_id => @cache.id
    assert_response :success
  end

  test "should create log_entry" do
    assert_difference('LogEntry.count') do
      post :create, :fruit_cache_id => @cache.id, :log_entry => @log_entry.attributes
    end

    assert_redirected_to fruit_cache_path(@cache)
  end

  test "should show log_entry" do
    get :show, :fruit_cache_id => @cache.id, :id => @log_entry.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :fruit_cache_id => @cache.id, :id => @log_entry.to_param
    assert_response :success
  end

  test "should update log_entry" do
    put :update, :fruit_cache_id => @cache.id, :id => @log_entry.to_param, :log_entry => @log_entry.attributes
    assert_redirected_to fruit_cache_path(@cache)
  end

  test "should destroy log_entry" do
    assert_difference('LogEntry.count', -1) do
      delete :destroy, :fruit_cache_id => @cache.id, :id => @log_entry.to_param
    end

    assert_redirected_to fruit_cache_path(@cache)
  end
end
