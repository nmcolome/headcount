require 'pry'
class Enrollment
  attr_reader :name, :kindergarten_participation

  def initialize(args)
    @name = args[:name]
    @kindergarten_participation = args[:kindergarten_participation] #|| generate_participation
  end

  # def generate_participation
  #   "It's gonna be ok!"
  # end
  
  def kindergarten_participation_by_year
    kindergarten_participation.keys.each do |key|
      kindergarten_participation[key] = kindergarten_participation[key].to_s[0..4].to_f
    end
    kindergarten_participation
  end

  def kindergarten_participation_in_year(year)
    year = year.to_i
    kindergarten_participation_by_year[year]
  end
end