require_relative 'repository_module'
require_relative 'statewide_test'

class StatewideTestRepository
  include Repository
  attr_reader :statewide_tests

  def load_data(args)
    enrollment = args[:enrollment]
    statewide_testing = args[:statewide_testing]
    economic_profile = args[:economic_profile]
    data_set = get_data(args)
    initialize_instances(data_set)
    data_set
  end

  def initialize_instances(data_set)
    @statewide_tests = {}
    unique_districts(data_set).each do |district_name|
      third_grade_data = get_testing_data_by_grade(district_name, data_set, :third_grade)
      eighth_grade_data = get_testing_data_by_grade(district_name, data_set, :eighth_grade)
      math_data = get_testing_data_by_ethnicity(district_name, data_set, :math)
      reading_data = get_testing_data_by_ethnicity(district_name, data_set, :reading)
      writing_data = get_testing_data_by_ethnicity(district_name, data_set, :writing)
      @statewide_tests[district_name.upcase] = StatewideTest.new({
                                                    :name => district_name.upcase,
                                                    :third_grade_data => third_grade_data,
                                                    :eighth_grade_data => eighth_grade_data,
                                                    :math_data => math_data,
                                                    :reading_data => reading_data,
                                                    :writing_data => writing_data
                                                  })
    end
  end

  def find_by_name(district_name)
    statewide_tests[district_name.upcase]
  end

  def get_district_data(district_name, data_set, file_key)
    district_data = []
    data_set[:statewide_testing][file_key].rewind
    data_set[:statewide_testing][file_key].each do |row|
      if district_name.upcase == row[:location].upcase
        district_data << row
      end
    end
    district_data
  end

  def get_testing_data_by_grade(district_name, data_set, file_key)
    district_data = get_district_data(district_name, data_set, file_key)
    file_key = {}
    unique_years = find_unique_years(district_data)
    unique_years.each do |year|
      file_key[year.to_i] = {}
      district_data.each do |row|
        if row[:timeframe] == year
          file_key[year.to_i][(row[:score]).downcase.to_sym] = row[:data]
        end
      end
    end
    file_key
  end

  def get_testing_data_by_ethnicity(district_name, data_set, file_key)
    district_data = get_district_data(district_name, data_set, file_key)
    file_key = {}
    unique_years = find_unique_years(district_data)
    unique_years.each do |year|
      file_key[year.to_i] = {}
      district_data.each do |row|
        if row[:timeframe] == year
          file_key[year.to_i][(row[:race_ethnicity]).downcase.to_sym] = row[:data]
        end
      end
    end
    file_key
  end

  def find_unique_years(district_data)
    unique_years = district_data.map do |row|
      row[:timeframe]
    end
    unique_years.uniq!
  end
end
