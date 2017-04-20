require_relative 'test_helper'

require './lib/result_set.rb'
require './lib/result_entry.rb'
require './lib/headcount_analyst'
require './lib/district_repository'

class TestResultSet < Minitest::Test

  def test_accesibility_to_matching_districts_data
    dr = DistrictRepository.new
    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/k_5lines.csv",
        :high_school_graduation => "./data/High school graduation rates.csv",
      },
      :economic_profile => {
        :median_household_income => "./data/Median household income.csv",
        :children_in_poverty => "./data/School-aged children in poverty.csv",
        :free_or_reduced_price_lunch => "./data/Students qualifying for free or reduced price lunch.csv",
        :title_i => "./test/fixtures/academy_title.csv"
      }
    })
    ha = HeadcountAnalyst.new(dr)
    rs = ha.high_income_disparity

    assert_instance_of ResultSet, rs
    assert_equal ResultEntry, rs.matching_districts.first.class
    assert_equal "HINSDALE COUNTY RE 1", rs.matching_districts.first.name
    assert_equal 63265, rs.matching_districts.first.median_household_income
    assert_equal 0.205, rs.matching_districts.first.children_in_poverty_rate
  end

  def test_accesibility_to_statewide_average_data
        dr = DistrictRepository.new
    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/k_5lines.csv",
        :high_school_graduation => "./data/High school graduation rates.csv",
      },
      :economic_profile => {
        :median_household_income => "./data/Median household income.csv",
        :children_in_poverty => "./data/School-aged children in poverty.csv",
        :free_or_reduced_price_lunch => "./data/Students qualifying for free or reduced price lunch.csv",
        :title_i => "./test/fixtures/academy_title.csv"
      }
    })
    ha = HeadcountAnalyst.new(dr)
    rs = ha.high_income_disparity

    assert_equal ResultEntry, rs.statewide_average.class
    assert_equal 57408, rs.statewide_average.median_household_income
    assert_equal 0.166, rs.statewide_average.children_in_poverty_rate
  end
end