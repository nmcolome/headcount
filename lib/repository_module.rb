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
    return new_instance(district_name.upcase) if is_district_in_data?(district_name) #For enrollment, might need add another argument or parameter option
  end

  def is_district_in_data?(district_name)
    @data.district.any? do |name|
      name.upcase == district_name.upcase
    end
  end

  def find_all_matching(district_name)
    matches = collect_matches(district_name)
    unique_locations(matches).map do |location|
      new_instance(location)
    end
  end

  def collect_matches(district_name)
    @data.district.find_all do |name|
      name.upcase.include?(district_name.upcase)
    end
  end

  def unique_locations(matches)
    matches.uniq.compact
  end

  def participation
    @data.participation 
  end

end