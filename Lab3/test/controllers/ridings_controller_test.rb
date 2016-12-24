require 'test_helper'

class RidingsControllerTest < ActionController::TestCase
  setup do
    @riding = ridings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ridings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create riding" do
    assert_difference('Riding.count') do
      post :create, riding: { active: @riding.active, first: @riding.first, name: @riding.name, second: @riding.second, visible: @riding.visible, winner: @riding.winner }
    end

    assert_redirected_to riding_path(assigns(:riding))
  end

  test "should show riding" do
    get :show, id: @riding
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @riding
    assert_response :success
  end

  test "should update riding" do
    patch :update, id: @riding, riding: { active: @riding.active, first: @riding.first, name: @riding.name, second: @riding.second, visible: @riding.visible, winner: @riding.winner }
    assert_redirected_to riding_path(assigns(:riding))
  end

  test "should destroy riding" do
    assert_difference('Riding.count', -1) do
      delete :destroy, id: @riding
    end

    assert_redirected_to ridings_path
  end
end
