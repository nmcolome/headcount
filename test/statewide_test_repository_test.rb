require_relative 'test_helper'

require './lib/statewide_test_repository.rb'

class TestStatewideTestRepository < Minitest::Test

  def setup
    @str = StatewideTestRepository.new
    @data = @str.load_data({
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
  end

  def test_it_exists
    assert_instance_of StatewideTestRepository, @str
  end

  def test_it_loads_data
      assert_equal Hash, @data.class
  end

  def test_find_by_name
    output_1 = @str.find_by_name("ACADEMY 20")
    assert_equal StatewideTest, output_1.class

    output_2 = @str.find_by_name("UNLIKELY NAME")
    assert_nil output_2

    output_3 = @str.find_by_name("academy 20")
    assert_equal StatewideTest, output_3.class
  end

  def test_access_to_statewide_test_object_3rd_grade_data
    output_1 = @str.find_by_name("ACADEMY 20")

    assert_equal Hash, output_1.third_grade_data.class
    assert_equal Hash, output_1.eighth_grade_data.class
    assert_equal Hash, output_1.math_data.class
    assert_equal Hash, output_1.reading_data.class
    assert_equal Hash, output_1.writing_data.class
  end
end