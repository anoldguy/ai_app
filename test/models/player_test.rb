require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  def setup
    @player = Player.new(name: "Test Player", birthdate: 25.years.ago.to_date)
  end

  test "should be valid with valid attributes" do
    assert @player.valid?
  end

  test "should require name" do
    @player.name = nil
    assert_not @player.valid?
    assert_includes @player.errors[:name], "can't be blank"
  end

  test "should require birthdate" do
    @player.birthdate = nil
    assert_not @player.valid?
    assert_includes @player.errors[:birthdate], "can't be blank"
  end

  test "name should be at least 2 characters" do
    @player.name = "A"
    assert_not @player.valid?
    assert_includes @player.errors[:name], "is too short (minimum is 2 characters)"
  end

  test "name should not exceed 50 characters" do
    @player.name = "A" * 51
    assert_not @player.valid?
    assert_includes @player.errors[:name], "is too long (maximum is 50 characters)"
  end

  test "birthdate should not be in the future" do
    @player.birthdate = 1.day.from_now.to_date
    assert_not @player.valid?
    assert_includes @player.errors[:birthdate], "cannot be in the future"
  end

  test "birthdate should not be more than 120 years ago" do
    @player.birthdate = 121.years.ago.to_date
    assert_not @player.valid?
    assert_includes @player.errors[:birthdate], "cannot be more than 120 years ago"
  end

  test "adult? should return true for players 18 and older" do
    @player.birthdate = 18.years.ago.to_date
    assert @player.adult?

    @player.birthdate = 25.years.ago.to_date
    assert @player.adult?
  end

  test "adult? should return false for players under 18" do
    @player.birthdate = 17.years.ago.to_date
    assert_not @player.adult?

    @player.birthdate = 5.years.ago.to_date
    assert_not @player.adult?
  end

  test "age method should calculate correct age from birthdate" do
    @player.birthdate = 25.years.ago.to_date
    assert_equal 25, @player.age

    @player.birthdate = Date.new(2000, 1, 1)
    expected_age = Date.current.year - 2000
    expected_age -= 1 if Date.current < Date.new(Date.current.year, 1, 1)
    assert_equal expected_age, @player.age
  end

  test "age method should return nil for nil birthdate" do
    @player.birthdate = nil
    assert_nil @player.age
  end

  test "display_age should return formatted age string" do
    @player.birthdate = 25.years.ago.to_date
    assert_equal "25 years old", @player.display_age
  end

  test "display_age should return unknown age for nil birthdate" do
    @player.birthdate = nil
    assert_equal "Unknown age", @player.display_age
  end

  test "adults scope should return only adult players" do
    # Clear existing data to avoid interference
    Player.delete_all
    
    adult_player = Player.create!(name: "Adult Player", birthdate: 25.years.ago.to_date)
    minor_player = Player.create!(name: "Minor Player", birthdate: 16.years.ago.to_date)

    adults = Player.adults
    assert_includes adults, adult_player
    assert_not_includes adults, minor_player
  end

  test "by_age scope should order players by age" do
    # Clear existing data to avoid interference
    Player.delete_all
    
    player1 = Player.create!(name: "Player 1", birthdate: 30.years.ago.to_date)
    player2 = Player.create!(name: "Player 2", birthdate: 20.years.ago.to_date)
    player3 = Player.create!(name: "Player 3", birthdate: 25.years.ago.to_date)

    ordered_players = Player.by_age
    assert_equal [player1, player3, player2], ordered_players.to_a
  end

  test "by_name scope should order players by name" do
    # Clear existing data to avoid interference
    Player.delete_all
    
    player1 = Player.create!(name: "Charlie", birthdate: 25.years.ago.to_date)
    player2 = Player.create!(name: "Alice", birthdate: 30.years.ago.to_date)
    player3 = Player.create!(name: "Bob", birthdate: 20.years.ago.to_date)

    ordered_players = Player.by_name
    assert_equal [player2, player3, player1], ordered_players.to_a
  end
end
