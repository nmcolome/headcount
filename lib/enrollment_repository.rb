require_relative 'repository_module'
require_relative 'data_table'
require 'csv'
require 'pry'

class EnrollmentRepository
  include Repository

  def new_instance(district_name)
    Enrollment.new({:name => district_name, :kindergarten_participation => get_kindergarten_participation(district_name) })
  end

  def get_kindergarten_participation(district_name)
    kinder_participation = district_participation.select do |district|
      district.first == district_name
    end
    kinder_participation.flatten.last
  end

end
