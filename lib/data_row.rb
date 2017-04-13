require 'csv'

class DataRow
  attr_reader :district, :year, :data_format, :data_value

  def initialize(row_data)
    @district = row_data[:location] # be aware of different names -- use \\
    @year = row_data[:timeframe]
    @data_format = row_data[:dataformat]
    @data_value = row_data[:data] #remember to add inst_variables for score, etc..
  end
end