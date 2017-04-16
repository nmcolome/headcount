require 'csv'
require_relative 'repository_module'
require_relative 'enrollment'

class EnrollmentRepository
  include Repository
  attr_reader :enrollments

  def initialize_instances(data_set)
    @enrollments = {}
    unique_districts(data_set).each do |district_name|
      district_participation = get_participation(data_set, district_name)
      @enrollments[district_name] = Enrollment.new({
                                                    :name => district_name,
                                                    :kindergarten_participation => district_participation
                                                  })
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

  def get_participation(data_set, district_name) 
    data_set[:enrollment][:kindergarten].rewind
    participation = {}
    data_set[:enrollment][:kindergarten].each do |row|
      if district_name.upcase == row[:location].upcase
        participation[(row[:timeframe])] = row[:data]
      end
    end
    participation
  end

    # if !data_set[:enrollment][:kindergarten].nil? 
      # data_set[:enrollment][:kindergarten].each do |row|
      # binding.pry    
        
      #   if district_name.upcase == row[:location].upcase
      #     participation[(row[:timeframe])] = row[:data]
      #   end
      # end
    # end
    


  # if data_set[:enrollment][:kindergarten].nil?
#   def get_kindergarten_participation(district_name)
#    
#    kinder_participation = district_participation(:enrollment, :kindergarten).select do |district|
#      district.first.upcase == district_name.upcase
#    end
#    kinder_participation.flatten.last
#  end
end