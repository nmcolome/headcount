require 'pry'

module Repository
  attr_reader :data

  def load_data(args)
    enrollment = args[:enrollment]
    #statewide_testing = args[:statewide_testing]
    #economic_profile = args[:economic_profile]
    kindergarten = enrollment[:kindergarten] 
    @data = DataTable.new(kindergarten) #iterate through hash to create each table
  end

  def find_by_name(district_name)
    # binding.pry
    district_is_in_data = @data.district.any? do |name|
      name.upcase == district_name.upcase
    end
    if district_is_in_data
      return new_instance(district_name.upcase) #For enrollment, might need add another argument or parameter option
    end
  end  

  def find_all_matching(district_name)
    matches = data.find_all do |row|
      district = row[:location]
      district.upcase.include?(district_name.upcase)
    end
    unique_locations = get_location_name(matches).uniq.compact
    unique_locations.map do |location|
      new_instance(location)
    end
  end

  def get_location_name(rows)
    rows.map do |row|
      row[:location]
    end
  end
end