require_relative 'exceptions'

class StatewideTest
  attr_reader :name,
              :third_grade_data,
              :eighth_grade_data,
              :math_data,
              :reading_data,
              :writing_data

  def initialize(args)
    @name = args[:name]
    @third_grade_data = args[:third_grade_data]
    @eighth_grade_data = args[:eighth_grade_data]
    @math_data = args[:math_data]
    @reading_data = args[:reading_data]
    @writing_data = args[:writing_data]
  end

  def races
    [
      :asian,
      :black,
      :pacific_islander,
      :hispanic,
      :native_american,
      :two_or_more,
      :white]
  end

  def subjects
    [:math, :reading, :writing]
  end

  def file_set
    [math_data, reading_data, writing_data]
  end

  def grades
    [3, 8]
  end

  def proficient_by_grade(grade)
    if grades.include?(grade)
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
      is_digit = data.to_s.split(//).all? do |char|
        ("0".."9").to_a.include?(char) || char == "."
        end
      if is_digit
        value[score] = data.to_s[0..4].to_f
      else
        value[score] = data.to_s
      end
    end
  end

  def proficient_by_race_or_ethnicity(selected_race)
    if races.include?(selected_race)
      profic = {}
      find_unique_years(file_set).each do |year|
        profic[year] = {}
        count = 0
        subjects.each do |name|
          profic[year][name] = file_set[count][year][selected_race][0..4].to_f
          count += 1
        end
      end
      profic
    else
      raise UnknownRaceError
    end
  end

  def find_unique_years(file_set)
    unique_years = file_set.map do |data_file|
      data_file.keys
    end
    unique_years.flatten.uniq!
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
    if grade_subject_year_match?(subject, grade, year)
      proficient_by_grade(grade)[year][subject]
    else
      raise UnknownDataError
    end
  end

  def grade_subject_year_match?(subject, grade, year)
    is_grade = grades.include?(grade)
    is_subject = subjects.include?(subject)
    is_year = find_unique_years([third_grade_data, eighth_grade_data]).include?(year)
    is_grade && subject && is_year
  end

  def proficient_for_subject_by_race_in_year(subject, race, year)
    if races.include?(race) && subjects.include?(subject) && find_unique_years(file_set).include?(year)
      proficient_by_race_or_ethnicity(race)[year][subject]
    else
      raise UnknownDataError
    end
  end
end
