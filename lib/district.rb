class District
  attr_reader :name, :enrollment_repository, :enrollment

  def initialize(args)
    @name = args[:name]
    @enrollment_repository = args[:enrollment_repository]
    @enrollment = enrollment_repository.enrollments[name]
  end
end