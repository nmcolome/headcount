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

    outcome = @ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'COLORADO')

    assert_equal 0.766, outcome
  end
end