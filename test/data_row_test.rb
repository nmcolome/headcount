require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/data_row.rb'
require 'csv'

class TestDataRow < Minitest::Test

  def test_if_it_exists
    contents = CSV.open("./data/Kindergartners in full-day program.csv", headers: true, header_converters: :symbol)
    d = ""
    contents.each do |row|
      d = DataRow.new(row)
    end
    assert_instance_of DataRow, d
  end

  def test_access_to_attributes
    contents = CSV.open("./data/Kindergartners in full-day program.csv", headers: true, header_converters: :symbol)
    d = ""
    contents.each do |row|
      d = DataRow.new(row)
    end
    
    assert_equal "YUMA SCHOOL DISTRICT 1", d.district
    assert_equal "2014", d.year
    assert_equal "Percent", d.data_format
    assert_equal "1", d.data_value
    
  end

end
