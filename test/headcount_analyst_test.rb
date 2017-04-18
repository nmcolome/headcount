require_relative 'test_helper'
require './lib/headcount_analyst'

class TestHeadcountAnalyst < Minitest::Test
 
  def test_it_exists
    dr = DistrictRepository.new
    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/k_5lines.csv",
        :high_school_graduation => "./test/fixtures/hs_5lines.csv",
      },
      :statewide_testing => {
        :third_grade => "./test/fixtures/third_5lines.csv",
        :eighth_grade => "./test/fixtures/eighth_5lines.csv",
        :math => "./test/fixtures/math_5lines.csv",
        :reading => "./test/fixtures/reading_5lines.csv",
        :writing => "./test/fixtures/writing_5lines.csv"
      }
    })

    ha = HeadcountAnalyst.new(dr)

    assert_instance_of HeadcountAnalyst, ha
  end

  def test_access_to_district_repository
    dr = DistrictRepository.new
    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/k_5lines.csv",
        :high_school_graduation => "./test/fixtures/hs_5lines.csv",
      },
      :statewide_testing => {
        :third_grade => "./test/fixtures/third_5lines.csv",
        :eighth_grade => "./test/fixtures/eighth_5lines.csv",
        :math => "./test/fixtures/math_5lines.csv",
        :reading => "./test/fixtures/reading_5lines.csv",
        :writing => "./test/fixtures/writing_5lines.csv"
      }
    })

    ha = HeadcountAnalyst.new(dr)
    assert_instance_of DistrictRepository, ha.district_repository
  end

  def test_kindergarten_participation_rate_variation
    # skip
    dr = DistrictRepository.new
    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./test/fixtures/hs_5lines.csv"
      }
    })
    ha = HeadcountAnalyst.new(dr)

    outcome_1 = ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'COLORADO')
    assert_equal 0.766, outcome_1

    outcome_2 = ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'YUMA SCHOOL DISTRICT 1')
    assert_equal 0.447, outcome_2
  end

  def test_kindergarten_participation_rate_variation_trend
    dr = DistrictRepository.new
    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/academy_k.csv",
        :high_school_graduation => "./test/fixtures/hs_5lines.csv",
      },
      :statewide_testing => {
        :third_grade => "./test/fixtures/third_5lines.csv",
        :eighth_grade => "./test/fixtures/eighth_5lines.csv",
        :math => "./test/fixtures/math_5lines.csv",
        :reading => "./test/fixtures/reading_5lines.csv",
        :writing => "./test/fixtures/writing_5lines.csv"
      }
    })
    ha = HeadcountAnalyst.new(dr)

    outcome = ha.kindergarten_participation_rate_variation_trend('ACADEMY 20', :against => 'COLORADO')
    expected = {2004 => 1.257, 2005 => 0.96, 2006 => 1.05, 2007 => 0.992, 2008 => 0.717, 2009 => 0.652, 2010 => 0.681, 2011 => 0.727, 2012 => 0.688, 2013 => 0.694, 2014 => 0.661 }
    
    assert_equal expected[2007], outcome[2007]
  end

  def test_graduation_rate_variation
    dr = DistrictRepository.new
    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/academy_k.csv",
        :high_school_graduation => "./test/fixtures/academy_hs.csv",
      },
      :statewide_testing => {
        :third_grade => "./test/fixtures/third_5lines.csv",
        :eighth_grade => "./test/fixtures/eighth_5lines.csv",
        :math => "./test/fixtures/math_5lines.csv",
        :reading => "./test/fixtures/reading_5lines.csv",
        :writing => "./test/fixtures/writing_5lines.csv"
      }
    })
    ha = HeadcountAnalyst.new(dr)

    outcome = ha.graduation_rate_variation('ACADEMY 20', :against => 'COLORADO')
    assert_equal 1.195, outcome
  end

  def test_kindergarten_participation_against_high_school_graduation
    dr = DistrictRepository.new
    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/academy_k.csv",
        :high_school_graduation => "./test/fixtures/academy_hs.csv",
      },
      :statewide_testing => {
        :third_grade => "./test/fixtures/third_5lines.csv",
        :eighth_grade => "./test/fixtures/eighth_5lines.csv",
        :math => "./test/fixtures/math_5lines.csv",
        :reading => "./test/fixtures/reading_5lines.csv",
        :writing => "./test/fixtures/writing_5lines.csv"
      }
    })
    ha = HeadcountAnalyst.new(dr)

    outcome = ha.kindergarten_participation_against_high_school_graduation('ACADEMY 20')
    assert_equal 0.641, outcome
  end

  def test_kindergarten_participation_correlates_with_high_school_graduation
    dr = DistrictRepository.new
    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/academy_k.csv",
        :high_school_graduation => "./test/fixtures/academy_hs.csv",
      },
      :statewide_testing => {
        :third_grade => "./test/fixtures/third_5lines.csv",
        :eighth_grade => "./test/fixtures/eighth_5lines.csv",
        :math => "./test/fixtures/math_5lines.csv",
        :reading => "./test/fixtures/reading_5lines.csv",
        :writing => "./test/fixtures/writing_5lines.csv"
      }
    })
    ha = HeadcountAnalyst.new(dr)

    outcome = ha.kindergarten_participation_correlates_with_high_school_graduation(for: 'ACADEMY 20')
    assert outcome
  end

  def test_kindergarten_participation_correlates_with_high_school_graduation_statewide
    dr = DistrictRepository.new
    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./data/High school graduation rates.csv"
      }
    })
    ha = HeadcountAnalyst.new(dr)

    outcome = ha.kindergarten_participation_correlates_with_high_school_graduation(:for => 'STATEWIDE')
    refute outcome
  end

  def test_kindergarten_participation_correlates_with_high_school_graduation_across_a_subset_of_districts
    dr = DistrictRepository.new
    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./data/High school graduation rates.csv"
      }
    })
    ha = HeadcountAnalyst.new(dr)

    outcome = ha.kindergarten_participation_correlates_with_high_school_graduation(:across => ['ACADEMY 20', 'STEAMBOAT SPRINGS RE-2', 'PARK (ESTES PARK) R-3'])
    assert outcome

    outcome_2 = ha.kindergarten_participation_correlates_with_high_school_graduation(:across => ['ACADEMY 20', 'MONTROSE COUNTY RE-1J', 'PARK (ESTES PARK) R-3'])
    refute outcome_2
  end
end