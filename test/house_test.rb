require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/room'
require './lib/house'

class HouseTest < Minitest::Test
  def setup
    @house = House.new("$400000", "123 sugar lane")
    @room_1 = Room.new(:bedroom, 10, 13)
    @room_2 = Room.new(:bedroom, 11, 15)
    @room_3 = Room.new(:living_room, 25, 15)
    @room_4 = Room.new(:basement, 30, 41)
    @room_5 = Room.new(:kitchen, 12, 14)
  end

  def test_house_exists
    assert_instance_of House, @house
  end

  def test_house_attributes
    assert_equal "$400000", @house.price
    assert_equal "123 sugar lane", @house.address
  end

  def test_house_returns_room_array_correctly
    assert_equal [], @house.rooms
    @house.add_room(@room_1)
    @house.add_room(@room_2)
    assert_equal [@room_1, @room_2], @house.rooms
  end

  def test_house_returns_array_of_rooms_by_category
    @house.add_room(@room_1)
    @house.add_room(@room_2)
    @house.add_room(@room_3)
    @house.add_room(@room_4)
    assert_equal [@room_1, @room_2], @house.rooms_from_category(:bedroom)
    assert_equal [@room_4], @house.rooms_from_category(:basement)
    assert_equal [], @house.rooms_from_category(:kitchen)
  end

  def test_house_area_computes_correctly
    assert_equal 0, @house.area
    @house.add_room(@room_1)
    assert_equal 130, @house.area
    @house.add_room(@room_2)
    assert_equal 295, @house.area
    @house.add_room(@room_3)
    assert_equal 670, @house.area
    @house.add_room(@room_4)
    assert_equal 1900, @house.area
  end

  def test_house_calculates_price_per_square_foot
    assert_nil @house.price_per_square_foot
    @house.add_room(@room_1)
    @house.add_room(@room_2)
    @house.add_room(@room_3)
    assert_equal 597.01, @house.price_per_square_foot
    @house.add_room(@room_4)
    assert_equal 210.53, @house.price_per_square_foot
  end

  def test_house_returns_rooms_sorted_by_area_largest_to_smallest
    @house.add_room(@room_1)
    @house.add_room(@room_2)
    @house.add_room(@room_3)
    @house.add_room(@room_4)
    assert_equal [@room_4,@room_3,@room_2,@room_1], @house.rooms_sorted_by_area
    @house.add_room(@room_5)
    assert_equal [@room_4,@room_3,@room_5,@room_2,@room_1], @house.rooms_sorted_by_area
  end
  def test_house_returns_hash_of_rooms_by_category
    @house.add_room(@room_1)
    @house.add_room(@room_2)
    @house.add_room(@room_3)
    @house.add_room(@room_4)
    returned_hash = @house.rooms_by_category
    assert_equal [@room_1,@room_2], returned_hash[:bedroom]
    assert_equal [@room_3], returned_hash[:living_room]
    assert_equal [@room_4], returned_hash[:basement]
  end
end
