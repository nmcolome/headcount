require_relative 'result_entry'

class ResultSet
  attr_reader :matching_districts_data,
              :statewide_average_data,
              :matching_districts,
              :statewide_average

  def initialize(args)
    @matching_districts_data = args[:matching_districts_data]
    @statewide_average_data = args[:statewide_average_data]
    @matching_districts = create_new_matching_instances(matching_districts_data)
    @statewide_average = create_new_statewide_instance(statewide_average_data)
  end

  def create_new_matching_instances(matching_districts_data)
    matching_districts = []
    matching_districts_data.each do |name, attributes|
      matching_districts << (name = ResultEntry.new(attributes))
    end
    matching_districts
  end

  def create_new_statewide_instance(statewide_average_data)
    ResultEntry.new(statewide_average_data)
  end
end