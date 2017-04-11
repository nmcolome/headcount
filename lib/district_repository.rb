require 'csv'
require_relative 'district'
require_relative 'repository_module'
require_relative 'data_table'

class DistrictRepository
  include Repository

  def new_instance(district_name)
    District.new({:name => district_name})
  end
end