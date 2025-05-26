require "test_helper"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player = players(:one)
    @user = users(:one)
    # Log in the user by creating a session
    post session_url, params: { email_address: @user.email_address, password: "password" }
  end

  test "should get index" do
    get players_url
    assert_response :success
  end

  test "should get new" do
    get new_player_url
    assert_response :success
  end

  test "should create player" do
    assert_difference("Player.count") do
      post players_url, params: { player: { name: "Test Player", birthdate: 25.years.ago.to_date } }
    end

    assert_redirected_to player_url(Player.last)
  end

  test "should show player" do
    get player_url(@player)
    assert_response :success
  end

  test "should get edit" do
    get edit_player_url(@player)
    assert_response :success
  end

  test "should update player" do
    patch player_url(@player), params: { player: { name: "Updated Name", birthdate: 30.years.ago.to_date } }
    assert_redirected_to player_url(@player)
  end

  test "should destroy player" do
    assert_difference("Player.count", -1) do
      delete player_url(@player)
    end

    assert_redirected_to players_url
  end

  test "should redirect unauthenticated user to login" do
    # Clear the session by making a DELETE request to session
    delete session_url
    
    get players_url
    assert_redirected_to new_session_url
  end
end
