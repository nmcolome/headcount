require 'csv'
module Repository

  def load_data(args)
    enrollment = args[:enrollment]
    statewide_testing = args[:statewide_testing]
    economic_profile = args[:economic_profile]
    data_set = get_data(args)
    enrollment_repository.initialize_instances(data_set)
    statewide_test_repository.initialize_instances(data_set)
    economic_profile_repository.initialize_instances(data_set)
    initialize_instances(data_set)
    binding.pry
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
    unique_names = []
    data_set.each do |key, value|
      if !value.nil?
        data_set[key] = value.each do |v_key, v_value|
          v_value.rewind
          v_value.each do |row|
            unique_names << row[:location]
          end
        end
      end
    end
    unique_names.uniq!
  end
#note to self: alter unique districts to iterate over data_set
  # def unique_districts(data_set)
  #   district_names = []
  #   unless data_set[:enrollment][:kindergarten].nil?
  #     data_set[:enrollment][:kindergarten].rewind
  #     data_set[:enrollment][:kindergarten].each do |row|
  #       district_names << row[:location]
  #     end
  #   end
  #   unless data_set[:enrollment][:high_school_graduation].nil?
  #     data_set[:enrollment][:high_school_graduation].rewind
  #     data_set[:enrollment][:high_school_graduation].each do |row|
  #       district_names << row[:location]
  #     end
  #   end
  #   district_names.uniq!
  # end

    #def unique_districts(data_set)
  #   district_names = []
  #   unless data_set[:enrollment][:kindergarten].nil?
  #     data_set[:enrollment][:kindergarten].rewind
  #     data_set[:enrollment][:kindergarten].each do |row|
  #       district_names << row[:location]
  #     end
  #   end
  #   unless data_set[:enrollment][:high_school_graduation].nil?
  #     data_set[:enrollment][:high_school_graduation].rewind
  #     data_set[:enrollment][:high_school_graduation].each do |row|
  #       district_names << row[:location]
  #     end
  #   end
  #   district_names.uniq!
  # end
end