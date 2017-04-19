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

  def test_get_children_in_poverty
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
    cip = epr.get_children_in_poverty(data_set, district_name)
    expected = {
                1995 => 0.032,
                1997 => 0.035,
                1999 => 0.032,
                2000 => 0.031,
                2001 => 0.029,
                2002 => 0.033,
                2003 => 0.037,
                2004 => 0.034,
                2005 => 0.042,
                2006 => 0.036,
                2007 => 0.039,
                2008 => 0.04404,
                2009 => 0.047,
                2010 => 0.05754,
                2011 => 0.059,
                2012 => 0.064,
                2013=>0.048
              }
    assert_equal expected, cip
  end

  def test_get_free_or_reduced_price_lunch
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
    free_or_reduced_lunch = epr.get_free_or_reduced_price_lunch(data_set, "ACADEMY 20")
    expected = {
                2014=>{:percentage=>0.12743, :total=>3132}, 
                2012=>{:percentage=>0.12539, :total=>3006}, 
                2011=>{:percentage=>0.1198, :total=>2834}, 
                2010=>{:percentage=>0.113, :total=>2601}, 
                2009=>{:percentage=>0.1034, :total=>2338}, 
                2013=>{:percentage=>0.13173, :total=>3225}, 
                2008=>{:percentage=>0.0939, :total=>2058}, 
                2007=>{:percentage=>0.08, :total=>1630}, 
                2006=>{:percentage=>0.0723, :total=>1534}, 
                2005=>{:percentage=>0.0587, :total=>1204}, 
                2004=>{:percentage=>0.0596, :total=>1182}, 
                2003=>{:percentage=>0.06, :total=>1062}, 
                2002=>{:percentage=>0.0484, :total=>905}, 
                2001=>{:percentage=>0.04714, :total=>855}, 
                2000=>{:percentage=>0.04, :total=>701}
                }
    assert_equal expected, free_or_reduced_lunch
  end
end