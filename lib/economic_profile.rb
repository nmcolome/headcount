require_relative 'exceptions'

class EconomicProfile
  attr_reader :median_household_income,
              :children_in_poverty,
              :free_or_reduced_price_lunch,
              :title_i,
              :name

  def initialize(args)
    @median_household_income = args[:median_household_income]
    @children_in_poverty = args[:children_in_poverty]
    @free_or_reduced_price_lunch = args[:free_or_reduced_price_lunch]
    @title_i = args[:title_i]
    @name = args[:name]
  end

  def median_household_income_in_year(year)
    if check_range_years(median_household_income).include?(year)
      incomes = get_incomes(year)
      average(incomes.compact)
    else
      raise UnknownDataError
    end
  end

  def median_household_income_average
    incomes = median_household_income.map { |years, value| value }
    average(incomes)
  end

  def check_range_years(file)
    unique_years = file.map do |years, value|
      (years.first..years.last).to_a
    end
    unique_years.flatten.uniq!
  end

  def get_incomes(year)
    median_household_income.map do |years, value|
      value if (years.first..years.last).to_a.include?(year)
    end
  end

  def average(data)
    if data.count != 0
      data.reduce(0) { |sum, number| sum + number} / data.count
    else
      0
    end
  end

  def children_in_poverty_in_year(year)
    if get_years(children_in_poverty).include?(year)
      children_in_poverty[year].to_s[0..4].to_f
    else
      raise UnknownDataError
    end
  end

  def get_years(file)
    file.map { |year, value| year }
  end

  def free_or_reduced_price_lunch_percentage_in_year(year)
    if get_years(free_or_reduced_price_lunch).include?(year)
      free_or_reduced_price_lunch[year][:percentage].to_s[0..4].to_f
    else
      raise UnknownDataError
    end
  end

  def free_or_reduced_price_lunch_number_in_year(year)
    if get_years(free_or_reduced_price_lunch).include?(year)
      free_or_reduced_price_lunch[year][:total].to_s[0..4].to_f
    else
      raise UnknownDataError
    end
  end

  def title_i_in_year(year)
    if get_years(title_i).include?(year)
      title_i[year].to_s[0..4].to_f
    else
      raise UnknownDataError
    end
  end

  def children_in_poverty_average
    children_rate = children_in_poverty.map { |years, value| value }
    average(children_rate)
  end

  def free_or_reduced_price_lunch_average
    reduced_lunch_average = free_or_reduced_price_lunch.map do |years, value|
      value[:percentage]
    end
    average(reduced_lunch_average)
  end
end