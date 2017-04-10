require_relative 'repository_module'
require 'csv'

class EnrollmentRepository
  include Repository

  def new_instance(district_name)
    Enrollment.new({:name => district_name})
  end
end