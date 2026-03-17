require 'test_helper'

class ErrorsControllerTest < ActionController::TestCase
  test "should get 404" do
    get :not_found
    assert_response :not_found
  end

  test "should get 500" do
    get :internal_server_error
    assert_response :internal_server_error
  end

end
