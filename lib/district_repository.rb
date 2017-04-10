require 'csv'
class DistrictRepository
  attr_reader :data
  def load_data(args)
    enrollment = args[:enrollment]
    #statewide_testing = args[:statewide_testing]
    #economic_profile = args[:economic_profile]
    kindergarten = enrollment[:kindergarten]
    @data = CSV.open(kindergarten, headers: true, header_converters: :symbol)
    data
  end

  def find_by_name(district_name)
    data.each do |row|
      district = row[:location]
      if district.upcase == district_name.upcase
        District.new({
          :name => district_name.upcase
        })
      else
        nil
      end
    end
  end

end



# dr = DistrictRepository.new
# dr.load_data({
#   :enrollment => {
#     :kindergarten => "./data/Kindergartners in full-day program.csv"
#   }
# })
# district = dr.find_by_name("ACADEMY 20")