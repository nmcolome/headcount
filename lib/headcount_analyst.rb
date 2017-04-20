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

  def kindergarten_participation_correlates_with_high_school_graduation(args)
    for_district = args[:for]
    across_districts = args[:across]
    all_district_correlations = []
    if for_district == 'STATEWIDE'
      all_district_correlations = []
      district_repository.districts.each do |district_name, district_data|
        all_district_correlations << individual_correlation(district_name)
      end
      statewide_correlation = all_district_correlations.count(true)/ all_district_correlations.length
      statewide_correlation >= 0.7
    elsif !for_district.nil?
      individual_correlation(for_district)
    elsif !across_districts.nil?
      across_districts.each do |district_name|
        all_district_correlations << individual_correlation(district_name)
      end
      statewide_correlation = all_district_correlations.count(true)/ all_district_correlations.length
      statewide_correlation >= 0.7
    end
  end

  def individual_correlation(for_district)
    correlation = kindergarten_participation_against_high_school_graduation(for_district)
    correlation >= 0.6 && correlation <= 1.5
  end

  def high_median_income
    median_average = {}
    district_repository.districts.each do |district_name|
      value = district_name.last.economic_profile.median_household_income_average
      key = district_name.first
      median_average[key] = value
    end
    high_disparity = []
    median_average.each do |district, value|
      if value > median_average["COLORADO"]
        high_disparity << district
      end
    end
    high_disparity
  end

  def high_children_in_poverty
    median_average = {}
    district_repository.districts.each do |district_name|
      value = district_name.last.economic_profile.children_in_poverty_average
      key = district_name.first
      median_average[key] = value
    end
    statewide_average = district_repository.districts.map do |district_name|
      district_name.last.economic_profile.children_in_poverty.map do |years, value|value
      end
    end
    statewide_average.flatten!.delete(0.0)
    median_average["COLORADO"] = calculate_average(statewide_average)
    high_disparity = []
    median_average.each do |district, value|
      if value > median_average["COLORADO"]
        high_disparity << district
      end
    end
    high_disparity
  end

  def high_income_disparity
    high_median_income & high_children_in_poverty
  end

  def high_graduation_rate
    graduation_average = {}
    district_repository.districts.each do |district_name|
      value = district_name.last.enrollment.graduation_rate_average
      key = district_name.first
      graduation_average[key] = value
    end
    high_disparity = []
    graduation_average.each do |district, value|
      if value > graduation_average["COLORADO"]
        high_disparity << district
      end
    end
    high_disparity
  end

  def high_reduced_lunch
    reduced_lunch_average = {}
    district_repository.districts.each do |district_name|
      value = district_name.last.economic_profile.free_or_reduced_price_lunch_average
      key = district_name.first
      reduced_lunch_average[key] = value
    end
    high_disparity = []
    reduced_lunch_average.each do |district, value|
      if value > reduced_lunch_average["COLORADO"]
        high_disparity << district
      end
    end
    high_disparity
  end

  def high_poverty_and_high_school_graduation
    high_graduation_rate & high_children_in_poverty & high_reduced_lunch
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