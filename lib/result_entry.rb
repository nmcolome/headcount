class ResultEntry
  attr_reader :free_and_reduced_price_lunch_rate, :children_in_poverty_rate, :high_school_graduation_rate, :median_household_income

  def initialize(args)
    @free_and_reduced_price_lunch_rate = args[:free_and_reduced_price_lunch_rate]
    @children_in_poverty_rate = args[:children_in_poverty_rate]
    @high_school_graduation_rate = args[:high_school_graduation_rate]
    @median_household_income = args[:median_household_income]
  end
end