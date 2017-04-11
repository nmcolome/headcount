require_relative 'repository_module'
require_relative 'data_table'
require 'csv'

class EnrollmentRepository
  include Repository

  def new_instance(district_name)
    Enrollment.new({:name => district_name})
  end
end