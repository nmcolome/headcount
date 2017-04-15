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

  def get_average_district_participation(name)
    district = initialize_district(name)
    district_participation = get_participation(district)
    calculate_average(district_participation)
  end

  def get_average_graduation_rate(name)
    district = initialize_district(name)
    graduation_rate = get_graduation_rate(district)
    calculate_average(graduation_rate)
  end

  def initialize_district(name)
    district_repository.find_by_name(name)
  end

  def get_participation(name)
    name.enrollment.kindergarten_participation_by_year
  end

  def get_graduation_rate(name)
    name.enrollment.graduation_rate_by_year
  end

  def calculate_average(value_set)
    value_set.values.reduce(0) { |sum,value| sum + value } / value_set.count
  end

  def variation(dividend, divisor)
    rate = dividend / divisor
    rate.round(3)
  end

  def kindergarten_participation_rate_variation_trend(district_name, comparison)
    district_set = get_district_participation_trend(district_name)
    comparison_set = get_district_participation_trend(comparison[:against])
    calculate_variation_trend([district_set, comparison_set])
  end

  def get_district_participation_trend(name)
    district = initialize_district(name)
    district_participation = get_participation(district)
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

  def calculate_variation_trend(combined_data_set)
    rate_variation_trend = {}
    merge_data(combined_data_set).each do |key, value|
      rate_variation_trend[key] = variation(value[0], value[1])
    end
    rate_variation_trend
  end

  def kindergarten_participation_against_high_school_graduation(district_name)
    correlation = kindergarten_participation_rate_variation(district_name, :against => 'COLORADO') / graduation_rate_variation(district_name, :against => 'COLORADO')
    correlation.to_s[0..4].to_f
  end

  def kindergarten_participation_correlates_with_high_school_graduation(for_district)
    if for_district[:for] == 'STATEWIDE'
      # all_districts = district_repository.data_set[:enrollment][:kindergarten].district.uniq
      # all_districts.shift
      all_district_correlations = []
      find_all_districts_with_data.each do |district|
        all_district_correlations << individual_correlation({:for => district})
        # binding.pry
      end
      statewide_correlation = all_district_correlations.count(true)/ all_district_correlations.length
      statewide_correlation >= 0.7
    else
      individual_correlation(for_district)
    end
  end

def find_all_districts_with_data
  all_kindergarten_districts = []
  district_repository.data_set[:enrollment][:kindergarten].contents.each do |row|
    if row.data_value.count("a-zA-Z") < 1
      all_kindergarten_districts << row.district
    end
  end
  all_kindergarten_districts.uniq!
  all_kindergarten_districts.shift

  all_high_school_districts = []
  district_repository.data_set[:enrollment][:high_school_graduation].contents.each do |row|
    if row.data_value.count("a-zA-Z") < 1
      all_high_school_districts << row.district
    end
  end
  all_high_school_districts.uniq!
  all_high_school_districts.shift
  
  all_kindergarten_districts & all_high_school_districts
end

  def individual_correlation(for_district)
    correlation = kindergarten_participation_against_high_school_graduation(for_district[:for])
    correlation >= 0.6 && correlation <= 1.5
  end

end