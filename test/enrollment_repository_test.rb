require_relative 'test_helper'

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
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./test/fixtures/small_hs_grad.csv"
      },
      :economic_profile => {
        :median_household_income => "./test/fixtures/small_median_house_income.csv",
        :children_in_poverty => "./test/fixtures/small_child_poverty.csv",
        :title_i => "./test/fixtures/small_title_1.csv"
      }})

    assert_equal Hash, data.class
  end

  def test_find_by_name_can_return_nil
    er = EnrollmentRepository.new
    data = er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./test/fixtures/small_hs_grad.csv"
      },
      :economic_profile => {
        :median_household_income => "./test/fixtures/small_median_house_income.csv",
        :children_in_poverty => "./test/fixtures/small_child_poverty.csv",
        :title_i => "./test/fixtures/small_title_1.csv"
      }})
    enrollment = er.find_by_name("UNLIKELY NAME")
    
    assert_nil enrollment
  end

  def test_find_by_name_can_return_enrollment_instance
    er = EnrollmentRepository.new
    data = er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./test/fixtures/small_hs_grad.csv"
      },
      :economic_profile => {
        :median_household_income => "./test/fixtures/small_median_house_income.csv",
        :children_in_poverty => "./test/fixtures/small_child_poverty.csv",
        :title_i => "./test/fixtures/small_title_1.csv"
      }})

    enrollment = er.find_by_name("ACADEMY 20")

    assert_equal Enrollment, enrollment.class
    assert_equal "0.30201", enrollment.kindergarten_participation[2004]
    assert_equal "0.88983", enrollment.graduation_rate[2012]
  end

  def test_find_by_name_can_return_enrollment_instance_with_lowercase_argument
    er = EnrollmentRepository.new
    data = er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./test/fixtures/small_hs_grad.csv"
      },
      :economic_profile => {
        :median_household_income => "./test/fixtures/small_median_house_income.csv",
        :children_in_poverty => "./test/fixtures/small_child_poverty.csv",
        :title_i => "./test/fixtures/small_title_1.csv"
      }})

    enrollment = er.find_by_name("academy 20")

    assert_equal Enrollment, enrollment.class
  end

  def test_find_all_matching_can_return_empty_array
    er = EnrollmentRepository.new
    data = er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./test/fixtures/small_hs_grad.csv"
      },
      :economic_profile => {
        :median_household_income => "./test/fixtures/small_median_house_income.csv",
        :children_in_poverty => "./test/fixtures/small_child_poverty.csv",
        :title_i => "./test/fixtures/small_title_1.csv"
      }})

    enrollments = er.find_all_matching("XXXXXRTY")

    assert_equal [], enrollments
  end

  def test_find_all_matching_can_return_array_of_matches
    er = EnrollmentRepository.new
    data = er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./test/fixtures/small_hs_grad.csv"
      },
      :economic_profile => {
        :median_household_income => "./test/fixtures/small_median_house_income.csv",
        :children_in_poverty => "./test/fixtures/small_child_poverty.csv",
        :title_i => "./test/fixtures/small_title_1.csv"
      }})

    enrollments = er.find_all_matching("WE")
    
    assert_equal Array, enrollments.class
    assert_equal 7, enrollments.count
    assert_equal Enrollment, enrollments.first.class
  end
end