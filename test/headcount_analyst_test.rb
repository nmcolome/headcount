require_relative 'test_helper'

require './lib/headcount_analyst'

class TestHeadcountAnalyst < Minitest::Test

  def setup
    @dr = DistrictRepository.new

    @data = @dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })

    @ha = HeadcountAnalyst.new(@dr)
  end
  
  def test_it_exists
    assert_instance_of HeadcountAnalyst, @ha
  end

  def test_kindergarten_participation_rate_variation

    outcome_1 = @ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'COLORADO')

    assert_equal 0.766, outcome_1

    outcome_2 = @ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'YUMA SCHOOL DISTRICT 1')
    
    assert_equal 0.447, outcome_2
  end

  def test_kindergarten_participation_rate_variation_trend

    outcome = @ha.kindergarten_participation_rate_variation_trend('ACADEMY 20', :against => 'COLORADO')
    expected = {2004 => 1.257, 2005 => 0.96, 2006 => 1.05, 2007 => 0.992, 2008 => 0.717, 2009 => 0.652, 2010 => 0.681, 2011 => 0.727, 2012 => 0.688, 2013 => 0.694, 2014 => 0.661 }
    assert_equal expected[2004], outcome[2004]
  end
end