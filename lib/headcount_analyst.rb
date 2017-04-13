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
    ("%.3f" % rate).to_f
  end
  
  def kindergarten_participation_rate_variation_trend(district_name, comparison)
    district = initialize_district(district_name)
    comparison_district = initialize_district(comparison[:against])
    district_set = get_participation(district)
    comparison_set = get_participation(comparison_district)
    combined_data_set = [district_set, comparison_set]
    merged_data_set = Hash.new{|hash, key| hash[key] = []} 
    combined_data_set.each do |district|
      district.each do |key, value|
        merged_data_set[key] << value
      end
    end
    rate_variation_trend = {}
    merged_data_set.each do |key, value|
      rate_variation_trend[key] = variation(value[0], value[1])
    end
    rate_variation_trend
  end
end