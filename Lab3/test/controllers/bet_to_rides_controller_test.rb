require 'test_helper'

class BetToRidesControllerTest < ActionController::TestCase
  setup do
    @bet_to_ride = bet_to_rides(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bet_to_rides)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bet_to_ride" do
    assert_difference('BetToRide.count') do
      post :create, bet_to_ride: { bet_id: @bet_to_ride.bet_id, bet_winner: @bet_to_ride.bet_winner, riding_id: @bet_to_ride.riding_id, success: @bet_to_ride.success }
    end

    assert_redirected_to bet_to_ride_path(assigns(:bet_to_ride))
  end

  test "should show bet_to_ride" do
    get :show, id: @bet_to_ride
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bet_to_ride
    assert_response :success
  end

  test "should update bet_to_ride" do
    patch :update, id: @bet_to_ride, bet_to_ride: { bet_id: @bet_to_ride.bet_id, bet_winner: @bet_to_ride.bet_winner, riding_id: @bet_to_ride.riding_id, success: @bet_to_ride.success }
    assert_redirected_to bet_to_ride_path(assigns(:bet_to_ride))
  end

  test "should destroy bet_to_ride" do
    assert_difference('BetToRide.count', -1) do
      delete :destroy, id: @bet_to_ride
    end

    assert_redirected_to bet_to_rides_path
  end
end
