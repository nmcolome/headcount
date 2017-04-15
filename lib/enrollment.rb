require 'pry'
class Enrollment
  attr_reader :name, :kindergarten_participation, :graduation_rate

  def initialize(args)
    @name = args[:name]
    @kindergarten_participation = args[:kindergarten_participation]
    @graduation_rate = args[:high_school_graduation]
  end

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

  def graduation_rate_by_year
    graduation_rate.keys.each do |key|
      graduation_rate[key] = graduation_rate[key].to_s[0..4].to_f
    end
    graduation_rate
  end

  def graduation_rate_in_year(year)
    year = year.to_i
    graduation_rate_by_year[year]
  end
end