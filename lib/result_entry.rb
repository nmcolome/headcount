class ResultEntry
  attr_reader :free_and_reduced_price_lunch_rate,
              :children_in_poverty_rate,
              :high_school_graduation_rate,
              :median_household_income,
              :name

  def initialize(set)
    # @set = set
    @name = set[:name]
    @free_and_reduced_price_lunch_rate = set[:free_and_reduced_price_lunch_rate]
    @children_in_poverty_rate = set[:children_in_poverty_rate]
    @high_school_graduation_rate = set[:high_school_graduation_rate]
    @median_household_income = set[:median_household_income]
  end
end