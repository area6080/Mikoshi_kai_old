require "test_helper"

class Public::UnionsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_unions_show_url
    assert_response :success
  end

  test "should get create" do
    get public_unions_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_unions_destroy_url
    assert_response :success
  end
end
