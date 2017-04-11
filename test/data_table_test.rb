require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/data_table.rb'

class TestDataTable < Minitest::Test

  def test_if_it_exists
    d = DataTable.new("./data/Kindergartners in full-day program.csv")
    assert_instance_of DataTable, d
  end

  def test_contents
    d = DataTable.new("./data/Kindergartners in full-day program.csv")
    output = d.get_contents

    assert_equal Array, output.class
    assert_equal DataRow, output.first.class
    assert_equal "Colorado", output.first.district
  end

  def test_participation
    d = DataTable.new("./data/Kindergartners in full-day program.csv")
    output = d.district_participation

    assert_equal 181, output.count
    assert_equal Array, output.class
    assert_equal Hash, output.first[1].class
  end
end
