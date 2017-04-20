require_relative 'test_helper'

require './lib/district.rb'
require './lib/district_repository'

class TestDistrict < Minitest::Test

  def test_if_it_exists
    dr = DistrictRepository.new
    dr.load_data(
      :enrollment => 
          {
          :kindergarten => './test/fixtures/k_5lines.csv',
          :high_school_graduation => './test/fixtures/hs_5lines.csv',
          },
      :statewide_testing => 
          {
          :third_grade => './test/fixtures/third_5lines.csv',
          :eighth_grade => './test/fixtures/eighth_5lines.csv',
          :math => './test/fixtures/math_5lines.csv',
          :reading => './test/fixtures/reading_5lines.csv',
          :writing => './test/fixtures/writing_5lines.csv'
          }
                )

    district = dr.find_by_name('ACADEMY 20')
    assert_instance_of District, district

    assert_equal 'ACADEMY 20', district.name
  end

  def test_access_to_attributes
    dr = DistrictRepository.new
    data = dr.load_data({
      :enrollment => {
        :kindergarten => './test/fixtures/k_5lines.csv',
        :high_school_graduation => './test/fixtures/hs_5lines.csv'
      },
      :statewide_testing => {
        :third_grade => './test/fixtures/third_5lines.csv',
        :eighth_grade => './test/fixtures/eighth_5lines.csv',
        :math => './test/fixtures/math_5lines.csv',
        :reading => './test/fixtures/reading_5lines.csv',
        :writing => './test/fixtures/writing_5lines.csv'
      }
    })

    district = dr.find_by_name('ACADEMY 20')
    assert_equal 'ACADEMY 20', district.name
    assert_equal 'ACADEMY 20', district.enrollment.name
    assert_equal 'ACADEMY 20', district.statewide_test.name
    assert_equal 'ACADEMY 20', district.economic_profile.name
  end
end
