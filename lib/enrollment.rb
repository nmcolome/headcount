class Enrollment
  attr_reader :name, :kindergarten_participation, :graduation_rate

  def initialize(args)
    @name = args[:name]
    @kindergarten_participation = args[:kindergarten_participation]
    @graduation_rate = args[:graduation_rate]
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

  def graduation_rate_by_year
    graduation_rate.each do |key, value|
      graduation_rate[key] = value.to_s[0..4].to_f
    end
  end

  def graduation_rate_in_year(year)
    return nil if graduation_rate[year].nil?
    graduation_rate[year].to_s[0..4].to_f
  end

  def graduation_rate_average
    graduation_average = graduation_rate.map { |years, value| value }
    average(graduation_average)
  end

  def average(data)
    data.reduce(0) { |sum, number| sum + number.to_f} / data.count
  end
end