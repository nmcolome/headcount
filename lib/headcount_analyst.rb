require_relative 'district_repository'

class HeadcountAnalyst
  attr_reader :district_repository
  
  def initialize(district_repository)
    @district_repository = district_repository
  end

  def kindergarten_participation_rate_variation(district_name, comparison)
    dividend = get_average_district_participation(district_name)
    divisor = get_average_district_participation(comparison[:against])
    
    variation(dividend, divisor)
  end
  
  def get_average_district_participation(name)
    district = initialize_district(name)
    district_participation = get_participation(district)
    calculate_average(district_participation)
  end

  def initialize_district(name)
    district_repository.find_by_name(name)
  end
  
  def get_participation(name)
    name.enrollment.kindergarten_participation_by_year
  end
  
  def calculate_average(value_set)
    value_set.values.reduce(0) { |sum,value| sum + value } / value_set.count
  end

  def variation(dividend, divisor)
    rate = dividend / divisor
    rate.to_s[0..4].to_f
  end
end