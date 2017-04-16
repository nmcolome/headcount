require_relative 'repository_module'
require_relative 'enrollment'

class EnrollmentRepository
  include Repository
  attr_reader :enrollments

  def initialize_instances(data_set)
    @enrollments = {}
    unique_districts(data_set).each do |district_name|
      @enrollments[district_name] = Enrollment.new({:name => district_name})
    end
  end

  def find_by_name(district_name)
    enrollments[district_name.upcase]
  end

  def find_all_matching(district_name)
    matches = []
    enrollments.each do |key, value|
      if key.upcase.include?(district_name.upcase)
        matches << value
      end
    end
    matches
  end
end