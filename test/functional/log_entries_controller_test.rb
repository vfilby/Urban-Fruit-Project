require 'test_helper'

class LogEntriesControllerTest < ActionController::TestCase
  setup do
    @cache = FactoryGirl.create :guelph_cache
    @log_entry = FactoryGirl.create :log_entry, :fruit_cache => @cache  
    user = FactoryGirl.create(:user)
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

  test "owner should get edit" do
    session[:user_id] = @log_entry.user.id
    
    get :edit, :fruit_cache_id => @cache.id, :id => @log_entry.to_param
    assert_response :success
  end
  
  test "other should not get edit" do
    assert_raise( CanCan::AccessDenied ) do
      get :edit, :fruit_cache_id => @cache.id, :id => @log_entry.to_param
    end
  end

  test "owner should update log_entry" do
    session[:user_id] = @log_entry.user.id
    
    put :update, :fruit_cache_id => @cache.id, :id => @log_entry.to_param, :log_entry => @log_entry.attributes
    assert_redirected_to fruit_cache_path(@cache)
  end
  
  test "other user should not update log_entry" do
    assert_raise( CanCan::AccessDenied ) do
      put :update, :fruit_cache_id => @cache.id, :id => @log_entry.to_param, :log_entry => @log_entry.attributes
    end
  end

  test "owner should destroy log_entry" do
    session[:user_id] = @log_entry.user.id
    
    assert_difference('LogEntry.count', -1) do
      delete :destroy, :fruit_cache_id => @cache.id, :id => @log_entry.to_param
    end

    assert_redirected_to fruit_cache_path(@cache)
  end
  
  test "other user should not destroy log_entry" do
    assert_raise( CanCan::AccessDenied ) do
      delete :destroy, :fruit_cache_id => @cache.id, :id => @log_entry.to_param
    end
  end
end
