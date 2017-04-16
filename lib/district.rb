require 'pry'
class District
  attr_reader :name, :enrollment

  def initialize(args)
    @name = args[:name]
    @enrollment = args[:enrollment]
    # binding.pry
    # @enrollment_repository = args[:enrollment_repository] 
    # @enrollment = enrollment_repository.enrollments[name] unless enrollment_repository.nil?
  end
end