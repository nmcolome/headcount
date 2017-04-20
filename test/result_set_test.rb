require_relative 'test_helper'

require './lib/result_set.rb'
require './lib/result_entry.rb'

class TestResultSet < Minitest::Test
  
  def test_it_exists
    r1 = ResultEntry.new({free_and_reduced_price_lunch_rate: 0.5,
      children_in_poverty_rate: 0.25,
        high_school_graduation_rate: 0.75})
    r2 = ResultEntry.new({free_and_reduced_price_lunch_rate: 0.3,
      children_in_poverty_rate: 0.2,
        high_school_graduation_rate: 0.6})
    rs = ResultSet.new(matching_districts: [r1], statewide_average: r2)

    assert_instance_of ResultSet, rs
    assert_equal [r1], rs.matching_districts
    assert_instance_of ResultEntry, rs.statewide_average
  end

  def test_accesibility_to_matching_districts_data
    r1 = ResultEntry.new({free_and_reduced_price_lunch_rate: 0.5,
      children_in_poverty_rate: 0.25,
        high_school_graduation_rate: 0.75})
    r2 = ResultEntry.new({free_and_reduced_price_lunch_rate: 0.3,
      children_in_poverty_rate: 0.2,
        high_school_graduation_rate: 0.6})

    rs = ResultSet.new(matching_districts: [r1], statewide_average: r2)

    assert_equal 0.5, rs.matching_districts.first.free_and_reduced_price_lunch_rate
    assert_equal 0.25, rs.matching_districts.first.children_in_poverty_rate
    assert_equal 0.75, rs.matching_districts.first.high_school_graduation_rate
    assert_nil rs.matching_districts.first.median_household_income
  end

  def test_accesibility_to_statewide_average_data
    r1 = ResultEntry.new({free_and_reduced_price_lunch_rate: 0.5,
      children_in_poverty_rate: 0.25,
        high_school_graduation_rate: 0.75})
    r2 = ResultEntry.new({free_and_reduced_price_lunch_rate: 0.3,
      children_in_poverty_rate: 0.2,
        high_school_graduation_rate: 0.6})

    rs = ResultSet.new(matching_districts: [r1], statewide_average: r2)

    assert_equal 0.3, rs.statewide_average.free_and_reduced_price_lunch_rate
    assert_equal 0.2, rs.statewide_average.children_in_poverty_rate
    assert_equal 0.6, rs.statewide_average.high_school_graduation_rate
    assert_nil rs.statewide_average.median_household_income
  end
end