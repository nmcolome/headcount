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
      district_data = get_district_data(data_set, district_name)
      third_grade_data = get_third_grade_data(district_data, district_name)
      @statewide_tests[district_name.upcase] = StatewideTest.new({
                                                    :name => district_name.upcase,
                                                    :third_grade_data => third_grade_data
                                                  })
    end
  end

  def find_by_name(district_name)
    statewide_tests[district_name.upcase]
  end

  # def get_third_grade_data(data_set) 
  #   data_set[:statewide_testing][:third_grade].rewind
  #   third_grade_data = {}
  #   data_set[:statewide_testing][:third_grade].each do |row|
  #     third_grade_data[(row[:location].upcase)] = {row[:timeframe] = [ 
  #                                                 row[:score]
  #                                                 #   :data => row[:data]
  #                                                 # }
  #     end
  #   third_grade_data
  # end


  def get_third_grade_data(district_data, district_name)
    third_grade_data = {}
    
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

  def get_district_data(data_set, district_name)
    district_data = []
    data_set[:statewide_testing][:third_grade].rewind
    data_set[:statewide_testing][:third_grade].each do |row|
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

end