require_relative 'test_helper'

require './lib/economic_profile_repository'

class TestEconomicProfileRepository < Minitest::Test

  def setup
    @epr = EconomicProfileRepository.new
    @data_set = @epr.load_data({
                          :economic_profile =>
                                              {
                                              :median_household_income => "./test/fixtures/academy_median.csv",
                                              :children_in_poverty => "./test/fixtures/academy_children.csv",
                                              :free_or_reduced_price_lunch => "./test/fixtures/academy_lunch.csv",
                                              :title_i => "./test/fixtures/academy_title.csv"
                                              }
                          })
  end

  def test_it_exists
    assert_instance_of EconomicProfileRepository, @epr
  end

  def test_it_loads_data
    assert_instance_of Hash, @data_set
  end

  def test_find_by_name_can_return_enrollment_instance
    ep = @epr.find_by_name("ACADEMY 20")
    assert_instance_of EconomicProfile, ep
  end

  def test_find_by_name_can_return_nil
    ep = @epr.find_by_name("UNLIKELY NAME")
    assert_nil ep
  end

  def test_get_median_household_income
    district_name = "ACADEMY 20"
    mhi = @epr.get_median_household_income(@data_set, district_name)
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
    district_name = "ACADEMY 20"
    cip = @epr.get_children_in_poverty(@data_set, district_name)
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
    district_name = "ACADEMY 20"
    free_or_reduced_lunch = @epr.get_free_reduced_lunch(@data_set, "ACADEMY 20")
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

    def test_get_title_i
    district_name = "ACADEMY 20"
    title_i = @epr.get_title_i(@data_set, "ACADEMY 20")
    expected = {
                2009=>0.014,
                2011=>0.011,
                2012=>0.01072,
                2013=>0.01246,
                2014=>0.0273
                }
    assert_equal expected, title_i
  end

  def test_load_data_manages_new_instances_if_load_data_arguments_empty
    empty_epr = EconomicProfileRepository.new
    data = empty_epr.load_data(
      :enrollment => {
                        :kindergarten => "./test/fixtures/k_5lines.csv",
                        :high_school_graduation => "./test/fixtures/hs_5lines.csv",
                      }
                              )
    assert_instance_of EconomicProfileRepository, empty_epr
    refute_instance_of EconomicProfile, empty_epr.economic_profiles
  end
end
