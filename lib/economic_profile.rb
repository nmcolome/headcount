class EconomicProfile
  attr_reader :median_household_income, :children_in_poverty, :free_or_reduced_price_lunch, :title_i, :name

  def initialize(args)
    @median_household_income = args[:median_household_income]
    @children_in_poverty = args[:children_in_poverty]
    @free_or_reduced_price_lunch = args[:free_or_reduced_price_lunch]
    @title_i = args[:title_i]
    @name = args[:name]
  end
end