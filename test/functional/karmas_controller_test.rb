require 'test_helper'

class KarmasControllerTest < ActionController::TestCase
  setup do
    @karma = karmas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:karmas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create karma" do
    assert_difference('Karma.count') do
      post :create, karma: @karma.attributes
    end

    assert_redirected_to karma_path(assigns(:karma))
  end

  test "should show karma" do
    get :show, id: @karma.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @karma.to_param
    assert_response :success
  end

  test "should update karma" do
    put :update, id: @karma.to_param, karma: @karma.attributes
    assert_redirected_to karma_path(assigns(:karma))
  end

  test "should destroy karma" do
    assert_difference('Karma.count', -1) do
      delete :destroy, id: @karma.to_param
    end

    assert_redirected_to karmas_path
  end
end
