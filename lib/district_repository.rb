require 'csv'
class DistrictRepository
  
  def load_data(args)
    enrollment = args[:enrollment]
    #statewide_testing = args[:statewide_testing]
    #economic_profile = args[:economic_profile]
    kindergarten = enrollment[:kindergarten]
    data = CSV.open(kindergarten, headers: true, header_converters: :symbol)
    data
  end

  # def other_method(args)
  #   kindergarten = args[:kindergarten]
  # end

end



# dr = DistrictRepository.new
# dr.load_data({
#   :enrollment => {
#     :kindergarten => "./data/Kindergartners in full-day program.csv"
#   }
# })
# district = dr.find_by_name("ACADEMY 20")