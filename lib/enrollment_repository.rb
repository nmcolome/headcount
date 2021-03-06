require_relative 'repository_module'
require_relative 'enrollment'

class EnrollmentRepository
  include Repository
  attr_reader :enrollments

  def load_data(args)
    enrollment = args[:enrollment]
    statewide_testing = args[:statewide_testing]
    economic_profile = args[:economic_profile]
    data_set = get_data(args)
    initialize_instances(data_set)
    data_set
  end

  def initialize_instances(data_set)
    @enrollments = {}
    unique_districts(data_set).each do |name|
      unless k_nil?(data_set)
        district_participation = get_participation(data_set, name)
      end
      unless hs_nil?(data_set)
        district_graduation_rate = get_graduation_rate(data_set, name)
      end
      @enrollments[name.upcase] = Enrollment.new({
        :name => name.upcase,
        :kindergarten_participation => district_participation,
        :graduation_rate => district_graduation_rate
      })
    end
  end

  def k_nil?(data_set)
    data_set[:enrollment][:kindergarten].nil?
  end

  def hs_nil?(data_set)
    data_set[:enrollment][:high_school_graduation].nil?
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

  def get_participation(data_set, name)
    data_set[:enrollment][:kindergarten].rewind
    participation = {}
    data_set[:enrollment][:kindergarten].each do |row|
      if name.upcase == row[:location].upcase
        participation[(row[:timeframe]).to_i] = row[:data]
      end
    end
    participation
  end

  def get_graduation_rate(data_set, name)
    data_set[:enrollment][:high_school_graduation].rewind
    graduation_rate = {}
    data_set[:enrollment][:high_school_graduation].each do |row|
      if name.upcase == row[:location].upcase
        graduation_rate[(row[:timeframe]).to_i] = row[:data]
      end
    end
    graduation_rate
  end
end