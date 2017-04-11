require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/district_repository'

class TestDistrictRepository < Minitest::Test
  
  def test_it_exists
    dr = DistrictRepository.new

    assert_instance_of DistrictRepository, dr
  end

  def test_it_loads_data
    dr = DistrictRepository.new

    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })

    assert_equal DataTable, data.class
  end

  def test_find_by_name_can_return_nil
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
end