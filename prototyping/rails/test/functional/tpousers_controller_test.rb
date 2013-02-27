require 'test_helper'

class TpousersControllerTest < ActionController::TestCase
  setup do
    @tpouser = tpousers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tpousers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tpouser" do
    assert_difference('Tpouser.count') do
      post :create, tpouser: { user: @tpouser.user }
    end

    assert_redirected_to tpouser_path(assigns(:tpouser))
  end

  test "should show tpouser" do
    get :show, id: @tpouser
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tpouser
    assert_response :success
  end

  test "should update tpouser" do
    put :update, id: @tpouser, tpouser: { user: @tpouser.user }
    assert_redirected_to tpouser_path(assigns(:tpouser))
  end

  test "should destroy tpouser" do
    assert_difference('Tpouser.count', -1) do
      delete :destroy, id: @tpouser
    end

    assert_redirected_to tpousers_path
  end
end
