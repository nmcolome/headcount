class District
  attr_reader :name, :enrollment, :statewide_test, :economic_profile

  def initialize(args)
    @name = args[:name]
    @enrollment = args[:enrollment]
    @statewide_test = args[:statewide_test]
    @economic_profile = args[:economic_profile]
  end
end
