require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  
  setup do
    @trillium = FactoryGirl.create(:tag)
    @poisonous = FactoryGirl.create(:tag)
    user = FactoryGirl.create( :user, id: 2 )
    session[:user_id] = user.id
  end
  
  test "should route to tag index" do
    assert_routing '/tags', { :controller => "tags", :action => "index" }
  end
  
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, :id => @trillium.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @trillium.to_param
    assert_response :success
  end

  test "should update tag" do
    put :update, :id => @trillium.to_param, :tag => @trillium.attributes
    assert_redirected_to tag_path(assigns(:tag))
  end
end
