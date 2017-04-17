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

      @statewide_tests[district_name.upcase] = StatewideTest.new({
                                                    :name => district_name.upcase})
    end
  end

  def find_by_name(district_name)
    statewide_tests[district_name.upcase]
  end

  def get_p(data_set, district_name)
    data_set[:enrollment][:high_school_graduation].rewind
    graduation_rate = {}
    data_set[:enrollment][:high_school_graduation].each do |row|
      if district_name.upcase == row[:location].upcase
        graduation_rate[(row[:timeframe]).to_i] = row[:data]
      end
    end
    graduation_rate
  end
end