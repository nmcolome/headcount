require_relative 'test_helper'

require './lib/district.rb'
require './lib/district_repository'

class TestDistrict < Minitest::Test

  def test_if_it_exists
    dr = DistrictRepository.new

    output = dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/small_kinder.csv",
        :high_school_graduation => "./test/fixtures/small_hs_grad.csv"
      },
      :economic_profile => {
        :median_household_income => "./test/fixtures/small_median_house_income.csv",
        :children_in_poverty => "./test/fixtures/small_child_poverty.csv",
        :title_i => "./test/fixtures/small_title_1.csv"
      }})

    district = dr.find_by_name("ACADEMY 20")
    assert_instance_of District, district

    assert_equal "ACADEMY 20", district.name
  end

end
