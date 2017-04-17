require_relative 'test_helper'

require './lib/statewide_test_repository.rb'

class TestStatewideTestRepository < Minitest::Test

  def test_it_exists
    str = StatewideTestRepository.new
    
    assert_instance_of StatewideTestRepository, str
  end

  def test_it_loads_data
    str = StatewideTestRepository.new
    data = str.load_data({
        :statewide_testing => {
        :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
        :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
        :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
        :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
        :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
      }
    })
      assert_equal Hash, data.class
  end

  def test_find_by_name
      str = StatewideTestRepository.new
      str.load_data({
        :statewide_testing => {
        :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
        :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
        :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
        :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
        :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
      }
    })

    output_1 = str.find_by_name("ACADEMY 20")
    assert_equal StatewideTest, output_1.class

    output_2 = str.find_by_name("UNLIKELY NAME")
    assert_nil output_2

    output_3 = str.find_by_name("academy 20")
    assert_equal StatewideTest, output_3.class
  end

  def test_access_to_statewide_test_object_3rd_grade_data
    str = StatewideTestRepository.new
      str.load_data({
        :statewide_testing => {
        :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
        :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
        :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
        :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
        :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
      }
    })

    output_1 = str.find_by_name("ACADEMY 20")

    assert_equal Hash, output_1.third_grade_data.class    
    assert_equal Hash, output_1.eighth_grade_data.class
    assert_equal Hash, output_1.math_data.class
    assert_equal Hash, output_1.reading_data.class
    assert_equal Hash, output_1.writing_data.class
  end
end 