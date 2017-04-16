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

  def graduation_rate_variation(district_name, comparison)
    dividend = get_average_graduation_rate(district_name)
    divisor = get_average_graduation_rate(comparison[:against])
    variation(dividend, divisor)
  end

  def kindergarten_participation_rate_variation_trend(district_name, comparison)
   district_set = get_district_participation_trend(district_name)
   comparison_set = get_district_participation_trend(comparison[:against])
   calculate_variation_trend([district_set, comparison_set])
  end

  def get_district_participation_trend(name)
   district = district_repository.find_by_name(name)
   district.enrollment.kindergarten_participation
  end

  def get_average_district_participation(name)
    district = district_repository.find_by_name(name)
    participation = district.enrollment.kindergarten_participation.values
    calculate_average(participation)
  end

  def get_average_graduation_rate(name)
    district = district_repository.find_by_name(name)
    graduation = district.enrollment.graduation_rate.values
    calculate_average(graduation)
  end

  def calculate_variation_trend(combined_data_set)
   rate_variation_trend = {}
   merge_data(combined_data_set).each do |key, value|
     rate_variation_trend[key] = variation(value[0].to_f, value[1].to_f)
   end
   rate_variation_trend
  end

  def merge_data(combined_data_set)
   merged_data_set = Hash.new{|hash, key| hash[key] = []}
   combined_data_set.each do |district|
     district.each do |key, value|
       merged_data_set[key] << value
     end
   end
   merged_data_set
  end

  def kindergarten_participation_against_high_school_graduation(district_name)
    participation_variation = kindergarten_participation_rate_variation(district_name, :against => 'COLORADO')
    graduation_variation = graduation_rate_variation(district_name, :against => 'COLORADO')

    correlation = participation_variation / graduation_variation
    correlation.to_s[0..4].to_f
  end

  private

  def calculate_average(values)
   values.reduce(0) { |sum, value| sum + value.to_f } / values.count
  end

  def variation(dividend, divisor)
   rate = dividend / divisor
   rate.round(3)
  end
end