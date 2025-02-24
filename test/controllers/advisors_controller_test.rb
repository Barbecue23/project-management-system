require "test_helper"

class AdvisorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get advisors_index_url
    assert_response :success
  end
end
