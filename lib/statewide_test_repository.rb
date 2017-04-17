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
      third_grade_data = get_third_grade_data(district_name, data_set)
      eighth_grade_data = get_eighth_grade_data(district_name, data_set)
      math_data = get_math_data(district_name, data_set)
      reading_data = get_reading_data(district_name, data_set)
      writing_data = get_writing_data(district_name, data_set)
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

  def get_third_grade_data(district_name, data_set)
    third_grade_data = {}
    district_data = get_district_third_data(district_name, data_set)
    unique_years = find_unique_years(district_data) #[2008, 2009, 2010]
    unique_years.each do |year|
      third_grade_data[year.to_i] = {}
      district_data.each do |row|
        if row[:timeframe] == year
          third_grade_data[year.to_i][(row[:score]).downcase.to_sym] = row[:data]
        end
      end
    end
    third_grade_data
  end

  def get_eighth_grade_data(district_name, data_set)
    eighth_grade_data = {}
    district_data = get_district_eighth_data(district_name, data_set)
    unique_years = find_unique_years(district_data) #[2008, 2009, 2010]
    unique_years.each do |year|
      eighth_grade_data[year.to_i] = {}
      district_data.each do |row|
        if row[:timeframe] == year
          eighth_grade_data[year.to_i][(row[:score]).downcase.to_sym] = row[:data]
        end
      end
    end
    eighth_grade_data
  end

    def get_math_data(district_name, data_set)
    math_data = {}
    district_data = get_district_math_data(district_name, data_set)
    unique_years = find_unique_years(district_data) #[2008, 2009, 2010]
    unique_years.each do |year|
      math_data[year.to_i] = {}
      district_data.each do |row|
        if row[:timeframe] == year
          math_data[year.to_i][(row[:race_ethnicity]).downcase.to_sym] = row[:data]
        end
      end
    end
    math_data
  end

    def get_district_math_data(district_name, data_set)
    district_data = []
    data_set[:statewide_testing][:math].rewind
    data_set[:statewide_testing][:math].each do |row|
      if district_name.upcase == row[:location].upcase
        district_data << row
      end
    end
    district_data
  end


  def get_district_third_data(district_name, data_set)
    district_data = []
    data_set[:statewide_testing][:third_grade].rewind
    data_set[:statewide_testing][:third_grade].each do |row|
      if district_name.upcase == row[:location].upcase
        district_data << row
      end
    end
    district_data
  end

    def get_district_eighth_data(district_name, data_set)
    district_data = []
    data_set[:statewide_testing][:eighth_grade].rewind
    data_set[:statewide_testing][:eighth_grade].each do |row|
      if district_name.upcase == row[:location].upcase
        district_data << row
      end
    end
    district_data
  end

def find_unique_years(district_data)
  unique_years = district_data.map do |row|
    row[:timeframe]
  end
  unique_years.uniq!
end

    def get_reading_data(district_name, data_set)
    reading_data = {}
    district_data = get_district_reading_data(district_name, data_set)
    unique_years = find_unique_years(district_data) #[2008, 2009, 2010]
    unique_years.each do |year|
      reading_data[year.to_i] = {}
      district_data.each do |row|
        if row[:timeframe] == year
          reading_data[year.to_i][(row[:race_ethnicity]).downcase.to_sym] = row[:data]
        end
      end
    end
    reading_data
  end

    def get_district_reading_data(district_name, data_set)
    district_data = []
    data_set[:statewide_testing][:reading].rewind
    data_set[:statewide_testing][:reading].each do |row|
      if district_name.upcase == row[:location].upcase
        district_data << row
      end
    end
    district_data
  end

    def get_writing_data(district_name, data_set)
    writing_data = {}
    district_data = get_district_writing_data(district_name, data_set)
    unique_years = find_unique_years(district_data) #[2008, 2009, 2010]
    unique_years.each do |year|
      writing_data[year.to_i] = {}
      district_data.each do |row|
        if row[:timeframe] == year
          writing_data[year.to_i][(row[:race_ethnicity]).downcase.to_sym] = row[:data]
        end
      end
    end
    writing_data
  end

    def get_district_writing_data(district_name, data_set)
    district_data = []
    data_set[:statewide_testing][:writing].rewind
    data_set[:statewide_testing][:writing].each do |row|
      if district_name.upcase == row[:location].upcase
        district_data << row
      end
    end
    district_data
  end

end