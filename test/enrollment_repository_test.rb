require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/enrollment_repository'

class TestEnrollmentRepository < Minitest::Test

  def test_if_it_exists
    er = EnrollmentRepository.new
    assert_instance_of EnrollmentRepository, er
  end

  def test_it_loads_data
    er = EnrollmentRepository.new

    data = er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })

    assert_equal CSV, data.class
  end

  def test_find_by_name_can_return_nil
    er = EnrollmentRepository.new

    data = er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    
    enrollment = er.find_by_name("UNLIKELY NAME")
    
    assert_nil enrollment
  end

  def test_find_by_name_can_return_district_instance
    er = EnrollmentRepository.new

    data = er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })

    enrollment = er.find_by_name("ACADEMY 20")
    
    assert_equal Enrollment, enrollment.class
  end

  def test_find_by_name_can_return_enrollment_instance_with_lowercase_argument
    er = EnrollmentRepository.new

    data = er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })

    enrollment = er.find_by_name("academy 20")
    
    assert_equal Enrollment, enrollment.class
  end

  def test_find_all_matching_can_return_empty_array
    er = EnrollmentRepository.new

    data = er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })

    enrollments = er.find_all_matching("XXXXXRTY")

    assert_equal [], enrollments
  end

  def test_find_all_matching_can_return_array_of_matches
    er = EnrollmentRepository.new

    data = er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })

    enrollments = er.find_all_matching("academy")
    
    assert_equal Array, enrollments.class
    assert_equal 11, enrollments.count
    assert_equal Enrollment, enrollments.first.class
  end
end