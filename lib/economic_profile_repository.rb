require 'csv'
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
    unique_districts(data_set).each do |district_name|
      median_household_income = get_median_household_income(data_set, district_name)
      @economic_profiles[district_name.upcase] = EconomicProfile.new({
                                                                :median_household_income => median_household_income,
                                                                :children_in_poverty => {2012 => 0.1845},
                                                                :free_or_reduced_price_lunch => {2014 => {:percentage => 0.023, :total => 100}},
                                                                :title_i => {2015 => 0.543},
                                                                :name => "ACADEMY 20"
                                                              })
    end
  end

  def find_by_name(district_name)
    economic_profiles[district_name.upcase]
  end

  def get_median_household_income(data_set, district_name)
    data_set[:economic_profile][:median_household_income].rewind
    median_household_income = {}
    data_set[:economic_profile][:median_household_income].each do |row|
      if (row[:location]).upcase == district_name.upcase
        key_name = row[:timeframe].split("-")
        key_name.map! { |year| year.to_i }
        median_household_income[key_name] = row[:data].to_i
      end
    end
    median_household_income
  end
end