require 'test_helper'

class FruitCachesControllerTest < ActionController::TestCase
  setup do
    @fruit_cach = fruit_caches(:one)
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

  test "should create fruit_cach" do
    assert_difference('FruitCache.count') do
      post :create, :fruit_cach => @fruit_cach.attributes
    end

    assert_redirected_to fruit_cach_path(assigns(:fruit_cach))
  end

  test "should show fruit_cach" do
    get :show, :id => @fruit_cach.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @fruit_cach.to_param
    assert_response :success
  end

  test "should update fruit_cach" do
    put :update, :id => @fruit_cach.to_param, :fruit_cach => @fruit_cach.attributes
    assert_redirected_to fruit_cach_path(assigns(:fruit_cach))
  end

  test "should destroy fruit_cach" do
    assert_difference('FruitCache.count', -1) do
      delete :destroy, :id => @fruit_cach.to_param
    end

    assert_redirected_to fruit_caches_path
  end
end
