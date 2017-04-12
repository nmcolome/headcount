#------------------------------------------------------
#------------------------------------------------------
require_relative 'data_table'
require_relative 'district_repository'
require_relative 'enrollment'
require 'csv'
require 'pry'

class EnrollmentRepository
  #include Repository
  attr_reader :data_set
  
  def get_data(data_set)
    @data_set = data_set
  end

  def district_participation
    @data_set.district_participation 
  end

  def new_instance(district_name)
    Enrollment.new({:name => district_name, :kindergarten_participation => get_kindergarten_participation(district_name) })
  end

  def get_kindergarten_participation(district_name)
    kinder_participation = district_participation.select do |district|
      district.first == district_name
    end
    kinder_participation.flatten.last
  end

  def find_by_name(district_name)
    return new_instance(district_name.upcase) if is_district_in_data?(district_name)
  end

  def is_district_in_data?(district_name)
    data_set.district.any? do |name|
      name.upcase == district_name.upcase
    end
  end
#------------------------------------------------------
#------------------------------------------------------
end
