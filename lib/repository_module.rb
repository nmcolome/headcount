require 'csv'
module Repository

  def load_data(args)
    enrollment = args[:enrollment]
    statewide_testing = args[:statewide_testing]
    economic_profile = args[:economic_profile]
    data_set = get_data(args)
    enrollment_repository.initialize_instances(data_set)
    initialize_instances(data_set)
    data_set
  end

  def get_data(arguments)
    data_set = {}
    arguments.each do |key, value|
      if !value.nil?
        data_set[key] = value.each do |v_key, v_value|
          value[v_key] = CSV.open(
                                  v_value,
                                  headers: true,
                                  header_converters: :symbol
                                  )
        end
      end
    end
    data_set
  end

  def unique_districts(data_set)
    district_names = []
    unless data_set[:enrollment][:kindergarten].nil?
      data_set[:enrollment][:kindergarten].rewind
      data_set[:enrollment][:kindergarten].each do |row|
        district_names << row[:location]
      end
    end
    unless data_set[:enrollment][:high_school_graduation].nil?
      data_set[:enrollment][:high_school_graduation].rewind
      data_set[:enrollment][:high_school_graduation].each do |row|
        district_names << row[:location]
      end
    end
    district_names.uniq!
  end
end
