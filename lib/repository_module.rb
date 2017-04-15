module Repository
  attr_reader :data

   def load_data(args)
    enrollment = args[:enrollment]
    statewide_testing = args[:statewide_testing]
    economic_profile = args[:economic_profile]

    get_data(args)
  end

  def get_data(arguments)
    @data_set = {}
    arguments.each do |key, value|
      if !value.nil?
        @data_set[key] = value.each do |v_key, v_value|
          value[v_key] = DataTable.new(v_value)
        end
      end
    end
    @data_set
  end

  def find_by_name(district_name)
    if is_district_in_data?(district_name)
      return new_instance(district_name.upcase)
    end
  end

  def is_district_in_data?(district_name)
    result = dig_through_data_set_for_district(district_name)
    if result.include?(true)
      true
    else
      false
    end
  end

  def dig_through_data_set_for_district(district_name)
    district_in_data = []
    @data_set.values.each do |value|
      value.each do |v_key, v_value|
        result = check_values_for_any_match(v_value, district_name)
        district_in_data << result
      end
    end
    district_in_data
  end

  def check_values_for_any_match(v_value, district_name)
    v_value.district.any? do |name|
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
    district_in_data = []
    @data_set.values.each do |value|
      value.each do |v_key, v_value|
        result = check_values_for_all_matches(v_value, district_name)
        district_in_data << result
      end
    end
    district_in_data
  end

  def check_values_for_all_matches(v_value, district_name)
    v_value.district.find_all do |name|
      name.upcase.include?(district_name.upcase)
    end
  end

  def unique_locations(matches)
    matches.flatten.uniq.compact
  end

  def district_participation
    @data_set[:enrollment][:kindergarten].district_participation
  end

  def all_participation_data(category, file_object)
    @data_set[category][file_object].contents.map do |row|
      [row.district, {row.year.to_i => row.data_value[0..4].to_f}]
    end
  end
end