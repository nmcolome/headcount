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

  def proficient_by_grade(grade)
    if grade == 3 || grade == 8
      proficiency_by_grade = format_data(grade)
    else
      proficiency_by_grade = raise Exception.new("UnknownDataError")
    end
    proficiency_by_grade
  end

  def format_data(grade)
    if grade == 3
      third_grade_data.each do |year, value|
        value.each do |score, data|
          binding.pry
          value[score] = data[0..4].to_f
        end
      end
    else
      eighth_grade_data.each do |year, value|
        value.each do |score, data|
          value[score] = data[0..4].to_f
        end
      end
    end
  end
end