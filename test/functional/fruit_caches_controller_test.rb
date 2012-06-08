require 'test_helper'

class FruitCachesControllerTest < ActionController::TestCase
  setup do
    @fruit_cache = FactoryGirl.create(:guelph_cache)
    @user = FactoryGirl.create( :user )
    @admin = FactoryGirl.create :admin_user
    
    session[:user_id] = @user.id
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

  test "should not be able to edit" do
    assert_raise( CanCan::AccessDenied ) do
      get :edit, :id => @fruit_cache.to_param
    end
  end
  
  # test "admin can edit" do
  #   session[:user_id] = @admin.id
  #   
  #   get :edit, :id => @fruit_cache.to_param
  #   assert_response :success
  # end
  
  test "owner can edit" do
    session[:user_id] = @fruit_cache.user.id
    
    get :edit, :id => @fruit_cache.to_param
    assert_response :success    
  end
  
  test "other should not update fruit_cache" do
    assert_raise( CanCan::AccessDenied ) do    
      put :update, :id => @fruit_cache.to_param, :fruit_cache => @fruit_cache.attributes
    end
  end

  # test "admin should update fruit_cache" do
  #   session[:user_id] = @admin.id
  #   
  #   put :update, :id => @fruit_cache.to_param, :fruit_cache => @fruit_cache.attributes
  #   assert_redirected_to fruit_cache_path(assigns(:fruit_cache))
  # end

  test "owner should update fruit_cache" do
    session[:user_id] = @fruit_cache.user.id
    
    put :update, :id => @fruit_cache.to_param, :fruit_cache => @fruit_cache.attributes
    assert_redirected_to fruit_cache_path(assigns(:fruit_cache))
  end

  test "should not be able to destroy fruit_cache" do
    assert_raise( CanCan::AccessDenied ) do
      delete :destroy, :id => @fruit_cache.to_param
    end
  end
  
  # test "admin can delete cache" do
  #   debugger
  #   session[:user_id] = @admin.id
  #   
  #   assert_difference('FruitCache.count', -1) do
  #     delete :destroy, :id => @fruit_cache.to_param
  #   end
  # 
  #   assert_redirected_to fruit_caches_path
  # end
end
