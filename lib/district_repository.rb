#------------------------------------------------------
#------------------------------------------------------
require 'csv'
require_relative 'district'
# require_relative 'repository_module'
require_relative 'data_table'
require 'pry'

class DistrictRepository
  attr_reader :data, :enrollment_repo
  
  def initialize
    @enrollment_repo = EnrollmentRepository.new
  end

  def new_instance(district_name, data, enrollment_repo)
    District.new({:name => district_name, :data_set => data, :enrollment_repository => enrollment_repo})
  end

  def load_data(args)
    enrollment = args[:enrollment]
    #statewide_testing = args[:statewide_testing]
    #economic_profile = args[:economic_profile]
    kindergarten = enrollment[:kindergarten] 
    @data = DataTable.new(kindergarten) #iterate through hash to create each table
  end

  def find_by_name(district_name)
    return new_instance(district_name.upcase, data, enrollment_repo) if is_district_in_data?(district_name)
  end
#------------------------------------------------------
#------------------------------------------------------
  def is_district_in_data?(district_name)
    @data.district.any? do |name|
      name.upcase == district_name.upcase
    end
  end

  def find_all_matching(district_name)
    matches = collect_matches(district_name)
    unique_locations(matches).map do |location|
      new_instance(location)
    end
  end

  def collect_matches(district_name)
    @data.district.find_all do |name|
      name.upcase.include?(district_name.upcase)
    end
  end

  def unique_locations(matches)
    matches.uniq.compact
  end

  def district_participation
    @data.district_participation 
  end

end