class ResultEntry
  attr_reader :free_and_reduced_price_lunch_rate, :children_in_poverty_rate, :high_school_graduation_rate, :median_household_income, :name

  def initialize(result_data)
    @result_data = result_data
    @name = result_data[:name]
    @free_and_reduced_price_lunch_rate = result_data[:free_and_reduced_price_lunch_rate]
    @children_in_poverty_rate = result_data[:children_in_poverty_rate]
    @high_school_graduation_rate = result_data[:high_school_graduation_rate]
    @median_household_income = result_data[:median_household_income]
  end
end