class Enrollment
  attr_reader :name, :kindergarten_participation

  def initialize(args)
    @name = args[:name]
    @kindergarten_participation = args[:kindergarten_participation]
  end
end