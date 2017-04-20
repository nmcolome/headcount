require_relative 'repository_module'
require_relative 'economic_profile'

class EconomicProfileRepository
  include Repository
  attr_reader :economic_profiles

  def load_data(args)
    enrollment = args[:enrollment]
    statewide_testing = args[:statewide_testing]
    economic_profile = args[:economic_profile]
    data_set = get_data(args)
    initialize_instances(data_set)
    data_set
  end

  def initialize_instances(data_set)
    @economic_profiles = {}
    unique_districts(data_set).each do |name|
      unless data_set[:economic_profile].nil?
        median_household_income = get_median_household_income(data_set, name)
        children_in_poverty = get_children_in_poverty(data_set, name)
        free_or_reduced_price_lunch = get_free_reduced_lunch(data_set, name)
        title_i = get_title_i(data_set, name)
      end
      @economic_profiles[name.upcase] = EconomicProfile.new({
        :median_household_income => median_household_income,
        :children_in_poverty => children_in_poverty,
        :free_or_reduced_price_lunch => free_or_reduced_price_lunch,
        :title_i => title_i,
        :name => name
      })
    end
  end

  def find_by_name(district_name)
    economic_profiles[district_name.upcase]
  end

  def get_median_household_income(data_set, name)
    data_set[:economic_profile][:median_household_income].rewind
    median_household_income = {}
    data_set[:economic_profile][:median_household_income].each do |row|
      if (row[:location]).upcase == name.upcase
        key_name = row[:timeframe].split("-")
        key_name.map! { |year| year.to_i }
        median_household_income[key_name] = row[:data].to_i
      end
    end
    median_household_income
  end

  def get_children_in_poverty(data_set, name)
    data_set[:economic_profile][:children_in_poverty].rewind
    children_in_poverty = {}
    data_set[:economic_profile][:children_in_poverty].each do |row|
      if name_percentage_match?(row, name)
        children_in_poverty[(row[:timeframe]).to_i] = row[:data].to_f
      end
    end
    children_in_poverty
  end

  def name_percentage_match?(row, name)
    name_match = row[:location].upcase == name.upcase
    data_format = row[:dataformat] == "Percent"
    name_match && data_format
  end

  def get_free_reduced_lunch(data_set, name)
    data_set[:economic_profile][:free_or_reduced_price_lunch].rewind
    lunch_percent = {}
    data_set[:economic_profile][:free_or_reduced_price_lunch].each do |row|
      if name_poverty_percentage_match?(row, name)
        lunch_percent[row[:timeframe].to_i] = {}
        lunch_percent[row[:timeframe].to_i][:percentage] = row[:data].to_f
      end
    end
    data_set[:economic_profile][:free_or_reduced_price_lunch].rewind
    lunch_num = {}
    data_set[:economic_profile][:free_or_reduced_price_lunch].each do |row|
      if name_poverty_number_match?(row, name)
        lunch_num[row[:timeframe].to_i] = {}
        lunch_num[row[:timeframe].to_i][:total] = row[:data].to_i
      end
    end

    free_reduced_lunch = {}
    lunch_percent.each do |key, value|
      free_reduced_lunch[key] = value.merge(lunch_num[key])

    end
    free_reduced_lunch
  end

  def name_poverty_percentage_match?(row, name)
    name_match = row[:location].upcase == name.upcase
    lunch_match = row[:poverty_level] == "Eligible for Free or Reduced Lunch"
    data_format = row[:dataformat] == "Percent"
    name_match && lunch_match && data_format
  end

  def name_poverty_number_match?(row, name)
    name_match = row[:location].upcase == name.upcase
    lunch_match = row[:poverty_level] == "Eligible for Free or Reduced Lunch"
    data_format = row[:dataformat] == "Number"
    name_match && lunch_match && data_format
  end

  def get_title_i(data_set, name)
    data_set[:economic_profile][:title_i].rewind
    title_i = {}
    data_set[:economic_profile][:title_i].each do |row|
      if (row[:location]).upcase == name.upcase
        is_digit = row[:data].to_s.split(//).all? do |char|
          ("0".."9").to_a.include?(char) || char == "."
        end
        if is_digit
          value = row[:data].to_f
        else
          value = row[:data]
        end
        title_i[(row[:timeframe]).to_i] = value
      end
    end
    title_i
  end
end
