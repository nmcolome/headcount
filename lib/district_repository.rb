#require 'csv'
require_relative 'repository_module'
require_relative 'district'
require_relative 'enrollment_repository'

class DistrictRepository
  include Repository
  attr_reader :districts, :enrollment_repository

  def initialize
    @enrollment_repository = EnrollmentRepository.new
  end

  def initialize_instances(data_set)
    @districts = {}
    unique_districts(data_set).each do |district_name|
      @districts[district_name] = District.new({
                                                :name => district_name,
                                                :enrollment_repository => enrollment_repository
                                              })
    end
  end

  # def unique_districts(data_set)
  #   district_names = []
  #   data_set[:enrollment][:kindergarten].each do |row|
  #     district_names << row[:location]
  #   end
  #   district_names.uniq!
  # end

  def find_by_name(district_name)
    districts[district_name.upcase]
  end

  def find_all_matching(district_name)
    matches = []
    districts.each do |key, value|
      if key.upcase.include?(district_name.upcase)
        matches << value
      end
    end
    matches
  end
end
