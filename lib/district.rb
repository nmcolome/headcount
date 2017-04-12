require_relative 'enrollment_repository'
require_relative 'district_repository'
#require_relative 'enrollment'
require 'pry'

class District
  attr_reader :name, :data_set, :enrollment

  def initialize(args)
    #binding.pry
    @name = args[:name]
    @data_set = args[:data_set]
    #binding.pry
    @enrollment = args[:enrollment] #.find_by_name(name)
    #binding.pry
    enrollment.get_data(data_set)
    #binding.pry
    #@enrollment = Enrollment.new(@name)
  end

 
end