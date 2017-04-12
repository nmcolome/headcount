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

  def test_automatic_creation_of_enrollment_repository
    dr = DistrictRepository.new

    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })

    assert_instance_of EnrollmentRepository, dr.enrollment_repository
  end

  def test_district_has_access_to_enrollment_repository
    dr = DistrictRepository.new

    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })

    district = dr.find_by_name("ACADEMY 20")
    
    assert_equal EnrollmentRepository, district.enrollment_repository.class
  end

  def test_district_has_access_to_data_set
    dr = DistrictRepository.new

    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })

    district = dr.find_by_name("ACADEMY 20")
    
    assert_equal DataTable, district.data_set.class
  end

  def test_district_has_access_to_enrollment_repository_data
    dr = DistrictRepository.new

    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })

    district = dr.find_by_name("ACADEMY 20")
    
    assert_equal DataTable, district.enrollment_repository.data_set.class
  end

  def test_district_can_create_new_enrollment_object
    dr = DistrictRepository.new

    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })

    district = dr.find_by_name("ACADEMY 20")
    
    assert_equal Enrollment, district.enrollment.class
  end

  def test_district_can_access_kindergarten_participation_in_year
    dr = DistrictRepository.new

    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })

    district = dr.find_by_name("ACADEMY 20")
    output = district.enrollment.kindergarten_participation_in_year(2010)
    
    assert_equal 0.436, output
  end
end