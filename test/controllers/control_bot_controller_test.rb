require 'test_helper'

class ControlBotControllerTest < ActionController::TestCase
   test "should get controlpage" do
     get :view
     assert_response :success
     assert_select 'h3', 'Manually control the bot'
   end

   test "should get replypage" do
     get :reply
     assert_response :success
     assert_select 'h3', 'Result:'
   end

end
