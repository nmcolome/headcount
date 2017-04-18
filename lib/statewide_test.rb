require_relative 'exceptions'

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
      format_data(grade)
    else
      raise UnknownDataError
    end
  end

  def format_data(grade)
    if grade == 3
      third_grade_data.each { |year, value| turn_data_to_f(value) }
    else
      eighth_grade_data.each { |year, value| turn_data_to_f(value) }
    end
  end

  def turn_data_to_f(value)
    value.each do |score, data|
      value[score] = data.to_s[0..4].to_f
    end
  end

  def proficient_by_race_or_ethnicity(race)
    file_set = [math_data, reading_data, writing_data]
    subject_names = [:math, :reading, :writing]
    proficient = {}
    find_unique_years(file_set).each do |year|
      proficient[year] = {}
      count = 0
      subject_names.each do |name|
        proficient[year][name] = (file_set[count][year][race])[0..4].to_f
        count += 1
      end
    end
    proficient
  end

  def find_unique_years(file_set)
    unique_years = file_set.map do |data_file|
      data_file.keys
    end
    unique_years.flatten.uniq!
  end
end