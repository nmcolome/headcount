require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/data.rb'

class TestDataTable < Minitest::Test

  def test_if_it_exists
    d = DataTable.new
    assert_instance_of DataTable, d
  end
end
