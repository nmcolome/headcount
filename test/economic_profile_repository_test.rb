require_relative 'test_helper'

require './lib/economic_profile_repository'

class TestEconomicProfileRepository < Minitest::Test

  def test_it_exists
    epr = EconomicProfileRepository.new
    assert_instance_of EconomicProfileRepository, epr
  end
  
  def test_it_loads_data
    epr = EconomicProfileRepository.new
    data = epr.load_data({
                          :economic_profile => 
                                              {
                                              :median_household_income => "./data/Median household income.csv",
                                              :children_in_poverty => "./data/School-aged children in poverty.csv",
                                              :free_or_reduced_price_lunch => "./data/Students qualifying for free or reduced price lunch.csv",
                                              :title_i => "./data/Title I students.csv"
                                              }
                          })
    assert_instance_of Hash, data
  end

  def test_find_by_name_can_return_enrollment_instance
    epr = EconomicProfileRepository.new
    data = epr.load_data({
                          :economic_profile => 
                                              {
                                              :median_household_income => "./data/Median household income.csv",
                                              :children_in_poverty => "./data/School-aged children in poverty.csv",
                                              :free_or_reduced_price_lunch => "./data/Students qualifying for free or reduced price lunch.csv",
                                              :title_i => "./data/Title I students.csv"
                                              }
                          })
    ep = epr.find_by_name("ACADEMY 20")
    assert_instance_of EconomicProfile, ep
  end

  def test_find_by_name_can_return_nil
    epr = EconomicProfileRepository.new
    data = epr.load_data({
                          :economic_profile => 
                                              {
                                              :median_household_income => "./data/Median household income.csv",
                                              :children_in_poverty => "./data/School-aged children in poverty.csv",
                                              :free_or_reduced_price_lunch => "./data/Students qualifying for free or reduced price lunch.csv",
                                              :title_i => "./data/Title I students.csv"
                                              }
                          })
    ep = epr.find_by_name("UNLIKELY NAME")
    assert_nil ep
  end
    
  def test_get_median_household_income
    epr = EconomicProfileRepository.new
    data_set = epr.load_data({
                          :economic_profile => 
                                              {
                                              :median_household_income => "./data/Median household income.csv",
                                              :children_in_poverty => "./data/School-aged children in poverty.csv",
                                              :free_or_reduced_price_lunch => "./data/Students qualifying for free or reduced price lunch.csv",
                                              :title_i => "./data/Title I students.csv"
                                              }
                          })
    district_name = "ACADEMY 20"
    mhi = epr.get_median_household_income(data_set, district_name)
    expected = {
                [2005, 2009] => 85060, 
                [2006, 2010] => 85450, 
                [2008, 2012] => 89615, 
                [2007, 2011] => 88099, 
                [2009, 2013] => 89953
              }
    assert_equal expected, mhi
  end
end