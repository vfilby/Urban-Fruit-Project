require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test "users index should_fail" do
    assert_raise( CanCan::AccessDenied ) { get :index }
  end

end
