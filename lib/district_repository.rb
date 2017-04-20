require_relative 'repository_module'
require_relative 'district'
require_relative 'enrollment_repository'
require_relative 'statewide_test_repository'
require_relative 'economic_profile_repository'

class DistrictRepository
  include Repository
  attr_reader :districts,
              :enrollment_repository,
              :statewide_test_repository,
              :economic_profile_repository

  def initialize
    @enrollment_repository = EnrollmentRepository.new
    @statewide_test_repository = StatewideTestRepository.new
    @economic_profile_repository = EconomicProfileRepository.new
  end

  def initialize_instances(data_set)
    @districts = {}
    unique_districts(data_set).each do |district_name|
      @districts[district_name.upcase] = District.new(
                                                      :name => district_name.upcase,
                                                      :enrollment => enrollment_repository.find_by_name(district_name),
                                                      :statewide_test => statewide_test_repository.find_by_name(district_name),
                                                      :economic_profile => economic_profile_repository.find_by_name(district_name)
                                                     )
    end
  end

  def find_by_name(district_name)
    districts[district_name.upcase]
  end

  def find_all_matching(district_name)
    matches = []
    districts.each do |key, value|
      matches << value if key.upcase.include?(district_name.upcase)
    end
    matches
  end
end
