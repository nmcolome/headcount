require 'csv'
require_relative 'district'
require_relative 'repository_module'
require_relative 'data_table'
require_relative 'enrollment_repository'

class DistrictRepository
  include Repository

  attr_reader :enrollment_repository, :data_set

  def initialize
    @enrollment_repository = EnrollmentRepository.new
  end

  def new_instance(district_name)
    District.new({:name => district_name,
                  :enrollment_repository => enrollment_repository,
                  :data_set => @data_set
                })
  end

  def load_data(args)
    enrollment = args[:enrollment]
    #statewide_testing = args[:statewide_testing]
    #economic_profile = args[:economic_profile]
    kindergarten = enrollment[:kindergarten]
    @data_set = DataTable.new(kindergarten)
  end
end