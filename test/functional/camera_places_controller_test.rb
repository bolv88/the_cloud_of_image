require 'test_helper'

class CameraPlacesControllerTest < ActionController::TestCase
  setup do
    @camera_place = camera_places(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:camera_places)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create camera_place" do
    assert_difference('CameraPlace.count') do
      post :create, camera_place: { place: @camera_place.place, status: @camera_place.status }
    end

    assert_redirected_to camera_place_path(assigns(:camera_place))
  end

  test "should show camera_place" do
    get :show, id: @camera_place
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @camera_place
    assert_response :success
  end

  test "should update camera_place" do
    put :update, id: @camera_place, camera_place: { place: @camera_place.place, status: @camera_place.status }
    assert_redirected_to camera_place_path(assigns(:camera_place))
  end

  test "should destroy camera_place" do
    assert_difference('CameraPlace.count', -1) do
      delete :destroy, id: @camera_place
    end

    assert_redirected_to camera_places_path
  end
end
