require_relative 'test_helper'

require './lib/enrollment_repository'

class TestEnrollmentRepository < Minitest::Test

  def setup
    @er = EnrollmentRepository.new
    @data = @er.load_data({
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

    @enrollment = @er.find_by_name("ACADEMY 20")
  end

  def test_if_it_exists
    assert_instance_of EnrollmentRepository, @er
  end

  def test_it_loads_data
    assert_equal Hash, @data.class
  end

  def test_find_by_name_can_return_nil
    enrollment = @er.find_by_name("UNLIKELY NAME")

    assert_nil enrollment
  end

  def test_find_by_name_can_return_enrollment_instance
    assert_equal Enrollment, @enrollment.class
    assert_equal "0.39159", @enrollment.kindergarten_participation[2007]
    assert_equal "0.895", @enrollment.graduation_rate[2010]
  end

  def test_find_by_name_can_return_enrollment_instance_with_lowercase_argument
    enrollment = @er.find_by_name("academy 20")
    assert_equal Enrollment, enrollment.class
  end

  def test_find_all_matching_can_return_empty_array
    enrollments = @er.find_all_matching("XXXXXRTY")
    assert_equal [], enrollments
  end

  def test_find_all_matching_can_return_array_of_matches
    enrollments = @er.find_all_matching("CO")
    
    assert_equal Array, enrollments.class
    assert_equal 2, enrollments.count
    assert_equal Enrollment, enrollments.first.class
  end
end