# frozen_string_literal: true

require "test_helper"

class Admin::PostEventsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_post_events_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_post_events_show_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_post_events_destroy_url
    assert_response :success
  end
end
