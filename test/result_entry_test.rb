require_relative 'test_helper'

require './lib/result_entry.rb'

class TestResultEntry < Minitest::Test

  def test_it_exists
    r1 = ResultEntry.new({free_and_reduced_price_lunch_rate: 0.5,
	                        children_in_poverty_rate: 0.25,
                          high_school_graduation_rate: 0.75})

    assert_instance_of ResultEntry, r1
  end

  def test_if_method_does_not_exist_it_returns_nil
    r1 = ResultEntry.new({free_and_reduced_price_lunch_rate: 0.5,
	                        children_in_poverty_rate: 0.25,
                          high_school_graduation_rate: 0.75})

    assert_equal 0.5, r1.free_and_reduced_price_lunch_rate
    assert_nil r1.median_household_income
  end
end