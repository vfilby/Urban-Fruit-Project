require 'test_helper'

class FruitCachesControllerTest < ActionController::TestCase
  setup do
    @fruit_cache = fruit_caches(:guelph_cache)
    user = users(:vfilby)
    session[:user_id] = user.id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fruit_caches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fruit_cache" do
    assert_difference('FruitCache.count') do
      post :create, :fruit_cache => @fruit_cache.attributes
    end

    assert_redirected_to fruit_cache_path(assigns(:fruit_cache))
  end

  test "should show fruit_cache" do
    get :show, :id => @fruit_cache.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @fruit_cache.to_param
    assert_response :success
  end

  test "should update fruit_cache" do
    put :update, :id => @fruit_cache.to_param, :fruit_cache => @fruit_cache.attributes
    assert_redirected_to fruit_cache_path(assigns(:fruit_cache))
  end

  test "should destroy fruit_cache" do
    assert_difference('FruitCache.count', -1) do
      delete :destroy, :id => @fruit_cache.to_param
    end

    assert_redirected_to fruit_caches_path
  end
end
