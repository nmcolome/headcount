class Enrollment
  attr_reader :name, :kindergarten_participation

  def initialize(args)
    @name = args[:name]
    @kindergarten_participation = args[:kindergarten_participation]
  end

  def kindergarten_participation_by_year
    kindergarten_participation.each do |key, value|
      kindergarten_participation[key] = value.to_s[0..4].to_f
    end
  end

  def kindergarten_participation_in_year(year)
    return nil if kindergarten_participation[year].nil?
    kindergarten_participation[year].to_s[0..4].to_f
  end
end