require_relative 'test_helper'

require './lib/economic_profile'

class TestEconomicProfile < Minitest::Test

  def setup
    @economic_profile = EconomicProfile.new({
        :median_household_income => {[2005, 2009] => 50000, [2008, 2014] => 60000},
        :children_in_poverty => {2012 => 0.1845},
        :free_or_reduced_price_lunch => {2014 => {:percentage => 0.023, :total => 100}},
        :title_i => {2015 => 0.543},
        :name => "ACADEMY 20"
       })
  end

  def test_it_exists
    assert_instance_of EconomicProfile, @economic_profile
  end

  def test_median_household_income_in_year
    skip
    assert_equal 50000, @economic_profile.median_household_income_in_year(2005)
    assert_equal 55000, @economic_profile.median_household_income_in_year(2009)
  end

  def test_median_household_income_average
    skip
    assert_equal 55000, @economic_profile.median_household_income_average
  end
end