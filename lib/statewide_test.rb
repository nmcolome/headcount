class StatewideTest
  attr_reader :name, :third_grade_data, :eighth_grade_data, :math_data, :reading_data, :writing_data

  def initialize(args)
    @name = args[:name]
    @third_grade_data = args[:third_grade_data]
    @eighth_grade_data = args[:eighth_grade_data]
    @math_data = args[:math_data]
    @reading_data = args[:reading_data]
    @writing_data = args[:writing_data]
  end
end
