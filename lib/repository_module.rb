module Repository
    attr_reader :data
  def load_data(args)
    enrollment = args[:enrollment]
    #statewide_testing = args[:statewide_testing]
    #economic_profile = args[:economic_profile]
    kindergarten = enrollment[:kindergarten]
    @data = CSV.open(kindergarten, headers: true, header_converters: :symbol)
    data
  end

  def find_by_name(district_name)
    data.find do |row|
      district = row[:location]
      if district.upcase == district_name.upcase
        return new_instance(district_name.upcase) #For enrollment, might need add another argument or parameter option
      end
    end
  end  

  def find_all_matching(district_name)
    matches = data.find_all do |row|
      district = row[:location]
      district.upcase.include?(district_name.upcase)
    end
    get_location_name(matches.compact)
  end

  def get_location_name(rows)
    rows.map do |row|
      row[:location]
    end
  end
end