class StatewideTest
  attr_reader :name, :third_grade_data

  def initialize(args)
    @name = args[:name]
    @third_grade_data = args[:third_grade_data]
    # @graduation_rate = args[:graduation_rate]
  end
end
