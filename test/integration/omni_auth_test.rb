require 'test_helper'

class OmniAuthTest < ActionController::TestCase
  
  setup do
     OmniAuth.config.test_mode = true
  end
  
  # test "user info should contain email" do
  #   get '/auth/google/callback'
  #   debugger
  #   
  # end

end
