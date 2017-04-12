require_relative 'enrollment_repository'
require_relative 'district_repository'
#require_relative 'enrollment'
require 'pry'

class District
  attr_reader :name, :data_set, :enrollment_repository, :enrollment

  def initialize(args)
   #------------------------------------------------------
   #------------------------------------------------------
    @name = args[:name]
    @data_set = args[:data_set]
    @enrollment_repository = args[:enrollment_repository]
    enrollment_repository.get_data(data_set)
    @enrollment = enrollment_repository.find_by_name(name)
    #------------------------------------------
    #------------------------------------------------------
  end

 
end