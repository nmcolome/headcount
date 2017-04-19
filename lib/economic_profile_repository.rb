require 'csv'
require_relative 'repository_module'

class EconomicProfileRepository
  include Repository

  def load_data(args)
    enrollment = args[:enrollment]
    statewide_testing = args[:statewide_testing]
    economic_profile = args[:economic_profile]
    data_set = get_data(args)
    # initialize_instances(data_set)
    # data_set
  end

  def initialize_instances(data_set)
    @economic_profiles = {}
    unique_districts(data_set).each do |district_name|
      @economic_profiles[district_name.upcase] = Enrollment.new({
                                                    :name => district_name.upcase,
                                                    :kindergarten_participation => district_participation,
                                                    :graduation_rate => district_graduation_rate
                                                  })
    end
  end

  def find_by_name(district_name)
    economic_profiles[district_name.upcase]
  end
end