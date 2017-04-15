require_relative 'test_helper'

require './lib/headcount_analyst'

class TestHeadcountAnalyst < Minitest::Test

  def setup
    @dr = DistrictRepository.new

    @data = @dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./data/High school graduation rates.csv"
      },
      :economic_profile => {
        :median_household_income => "./test/fixtures/small_median_house_income.csv",
        :children_in_poverty => "./test/fixtures/small_child_poverty.csv",
        :title_i => "./test/fixtures/small_title_1.csv"
      }})

    @ha = HeadcountAnalyst.new(@dr)
  end
  
  # def test_it_exists
  #   assert_instance_of HeadcountAnalyst, @ha
  # end

  # def test_kindergarten_participation_rate_variation

  #   outcome_1 = @ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'COLORADO')

  #   assert_equal 0.766, outcome_1

  #   outcome_2 = @ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'YUMA SCHOOL DISTRICT 1')
    
  #   assert_equal 0.447, outcome_2
  # end

  # def test_kindergarten_participation_rate_variation_trend

  #   outcome = @ha.kindergarten_participation_rate_variation_trend('ACADEMY 20', :against => 'COLORADO')
  #   expected = {2004 => 1.257, 2005 => 0.96, 2006 => 1.05, 2007 => 0.992, 2008 => 0.717, 2009 => 0.652, 2010 => 0.681, 2011 => 0.727, 2012 => 0.688, 2013 => 0.694, 2014 => 0.661 }
  #   assert_equal expected[2005], outcome[2005]
  # end

  # def test_kindergarten_participation_against_high_school_graduation
  #   outcome = @ha.kindergarten_participation_against_high_school_graduation('ACADEMY 20')

  #   assert_equal 0.648, outcome
  # end

  # def test_graduation_rate_variation

  #   outcome = @ha.graduation_rate_variation('ACADEMY 20', :against => 'COLORADO')

  #   assert_equal 1.181, outcome
  # end

  # def test_kindergarten_participation_correlates_with_high_school_graduation
  #   outcome = @ha.kindergarten_participation_correlates_with_high_school_graduation(for: 'ACADEMY 20')

  #   assert outcome
  # end

  def test_kindergarten_participation_correlates_with_high_school_graduation_statewide
    # skip
    outcome = @ha.kindergarten_participation_correlates_with_high_school_graduation(:for => 'STATEWIDE')
    assert_equal "cat", outcome
  end

end