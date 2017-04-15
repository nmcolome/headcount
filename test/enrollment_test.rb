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
    assert_equal Hash, participation_by_year.class
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
    er.load_data({
                  :enrollment => {
                    :kindergarten => "./data/Kindergartners in full-day program.csv",
                    :high_school_graduation => "./data/High school graduation rates.csv"
                  }
                })

    name = "GUNNISON WATERSHED RE1J"
    enrollment = er.find_by_name(name)
    assert_equal name, enrollment.name
    assert enrollment.is_a?(Enrollment)
    assert_in_delta 0.144, enrollment.kindergarten_participation_in_year(2004), 0.005
  end
  
end