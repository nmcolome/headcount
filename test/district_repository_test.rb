require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/district_repository'
require 'pry'

class TestDistrictRepository < Minitest::Test
  
  def test_it_exists
    skip
    dr = DistrictRepository.new

    assert_instance_of DistrictRepository, dr
  end

  def test_it_loads_data
    skip
    dr = DistrictRepository.new

    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })

    assert_equal DataTable, data.class
  end

  def test_find_by_name_can_return_nil
    skip
    dr = DistrictRepository.new

    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    
    district = dr.find_by_name("UNLIKELY NAME")
    
    assert_nil district
  end

  def test_find_by_name_can_return_district_instance
    skip
    dr = DistrictRepository.new

    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })

    district = dr.find_by_name("ACADEMY 20")
    
    assert_equal District, district.class
  end

  def test_find_by_name_can_return_district_instance_with_lowercase_argument
    skip
    dr = DistrictRepository.new

    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })

    district = dr.find_by_name("academy 20")
    
    assert_equal District, district.class
  end

  def test_find_all_matching_can_return_empty_array
    skip
    dr = DistrictRepository.new

    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })

    districts = dr.find_all_matching("XXXXXRTY")

    assert_equal [], districts
  end

  def test_find_all_matching_can_return_array_of_matches
    skip
    dr = DistrictRepository.new

    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })

    districts = dr.find_all_matching("we")

    assert_equal Array, districts.class
    assert_equal 7, districts.count
    assert_equal District, districts.first.class
  end

  def test_enrollment_repository_created_when_district_repository_is_initialized
    dr = DistrictRepository.new
    #binding.pry
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    #binding.pry
    district = dr.find_by_name("ACADEMY 20")
    #binding.pry
    assert_equal District, district.class
    assert_equal "ACADEMY 20", district.name
    assert_equal EnrollmentRepository, district.enrollment.class
    assert_equal DataTable, district.enrollment.data_set.class
    output = district.enrollment.kindergarten_participation_in_year(2010)
    # assert_equal 0.436, output
  end
end