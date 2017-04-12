class District
  attr_reader :name, :enrollment_repository, :data_set, :enrollment
  
  def initialize(args)
    @name = args[:name]
    @enrollment_repository = args[:enrollment_repository]
    @data_set = args[:data_set]
    enrollment_repository.get_data_set(data_set) unless data_set.nil?
    @enrollment = enrollment_repository.find_by_name(name) unless data_set.nil?
  end
end