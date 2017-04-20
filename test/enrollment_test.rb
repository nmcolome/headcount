require_relative 'test_helper'

require './lib/enrollment'
require './lib/enrollment_repository'

class TestEnrollment < Minitest::Test

  def setup
    @e = Enrollment.new({
      :name => "ACADEMY 20",
      :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}
    })
  end

  def test_it_exists
    assert_instance_of Enrollment, @e
    assert_equal Hash, @e.kindergarten_participation.class
    assert_equal [2010, 2011, 2012], @e.kindergarten_participation.keys
  end

  def test_kindergarten_participation_by_year
    participation_by_year = @e.kindergarten_participation_by_year
    expected = {2010=>0.391, 2011=>0.353, 2012=>0.267}
    assert_equal Hash, participation_by_year.class
    assert_equal expected, participation_by_year
  end

  def test_kindergarten_participation_in_year_can_return_participation
    participation_in_year = @e.kindergarten_participation_in_year(2010)
    assert_equal 0.391, participation_in_year
  end

  def test_kindergarten_participation_in_year_can_return_nil
    participation_in_year = @e.kindergarten_participation_in_year(2022)
    assert_nil participation_in_year

    participation_in_year = @e.kindergarten_participation_in_year(1999)
    assert_nil participation_in_year
  end

  def test_kindergarten_participation_in_year_will_reject_two_digit_input
    participation_in_year = @e.kindergarten_participation_in_year(07)
    assert_nil participation_in_year
  end

  def test_kindergarten_participation_in_year_in_delta
    er = EnrollmentRepository.new
    data = er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
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

    name = "GUNNISON WATERSHED RE1J"
    enrollment = er.find_by_name(name)
    assert_equal name, enrollment.name
    assert enrollment.is_a?(Enrollment)
    assert_in_delta 0.144, enrollment.kindergarten_participation_in_year(2004), 0.005
  end

  def test_graduation_rate_by_year
    er = EnrollmentRepository.new
    data = er.load_data({
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
    enrollment = er.find_by_name("ACADEMY 20")

    graduation_rate_by_year = enrollment.graduation_rate_by_year
    result = {2010=>0.895, 2011=>0.895, 2012=>0.889, 2013=>0.913, 2014=>0.898}
    assert_equal result, graduation_rate_by_year
  end

  def test_graduation_rate_in_year
    er = EnrollmentRepository.new
    data = er.load_data({
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
    enrollment = er.find_by_name("ACADEMY 20")

    graduation_rate_in_year = enrollment.graduation_rate_in_year(2010)
    assert_equal 0.895, graduation_rate_in_year
  end

  def test_graduation_rate_average
    er = EnrollmentRepository.new
    data = er.load_data({
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
    enrollment = er.find_by_name("ACADEMY 20")

    assert_equal 0.898312, enrollment.graduation_rate_average
  end
end