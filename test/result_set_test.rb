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
end