require_relative 'test_helper'

require './lib/statewide_test'
require './lib/statewide_test_repository'

class TestStatewideTest < Minitest::Test

  def setup
    @str = StatewideTestRepository.new
    @str.load_data({
        :statewide_testing => {
        :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
        :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
        :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
        :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
        :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
      }
    })

    @sw = @str.find_by_name("ACADEMY 20")
  end

  def test_it_exists
    swt = StatewideTest.new({:name => "ACADEMY 20"})

    assert_instance_of StatewideTest, swt
  end

  def test_proficient_by_grade
    assert_instance_of Hash, @sw.proficient_by_grade(3)
    expected = {
            2008=>{:math=>0.857, :reading=>0.866, :writing=>0.671},
            2009=>{:math=>0.824, :reading=>0.862, :writing=>0.706},
            2010=>{:math=>0.849, :reading=>0.864, :writing=>0.662},
            2011=>{:math=>0.819, :reading=>0.867, :writing=>0.678},
            2012=>{:reading=>0.87, :math=>0.83, :writing=>0.655},
            2013=>{:math=>0.855, :reading=>0.859, :writing=>0.668},
            2014=>{:math=>0.834, :reading=>0.831, :writing=>0.639}
          }

    assert_equal expected, @sw.proficient_by_grade(3)

    assert_raises(UnknownDataError) do
      @sw.proficient_by_grade(1)
    end
  end

  def test_proficient_by_race_or_ethnicity
    output = @sw.proficient_by_race_or_ethnicity(:asian)
    expected = {:math=>0.816, :reading=>0.897, :writing=>0.826}
    
    assert_equal expected, output[2011]
  end

  def test_proficient_for_subject_by_grade_in_year
    output = @sw.proficient_for_subject_by_grade_in_year(:math, 3, 2008)

    assert_equal 0.857, output

    output_2 = @sw.proficient_for_subject_by_grade_in_year(:math, 8, 2008)

    assert_equal 0.64, output_2
  end
end
