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
    statewide_testing = args[:statewide_testing]
    economic_profile = args[:economic_profile]

    get_data(args)
  end

  def get_data(*arguments)
    @data_set = {}
          # binding.pry    
    arguments.first.each do |key, value|
      if !value.nil?
        value.each do |v_key, v_value|
          # binding.pry
          @data_set[key] = (value[v_key] = DataTable.new(v_value))
        end
      end
    end
    p @data_set
  end

end