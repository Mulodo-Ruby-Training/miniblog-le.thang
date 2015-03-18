require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get create_user" do
    get :create_user
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get update_user" do
    get :update_user
    assert_response :success
  end

  test "should get search_user" do
    get :search_user
    assert_response :success
  end

  test "should get change_password" do
    get :change_password
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get change_permission" do
    get :change_permission
    assert_response :success
  end

end
