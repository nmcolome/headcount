require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/district.rb'

class TestDistrict < Minitest::Test

  def test_if_it_exists
    d = District.new
    assert_instance_of District, d
  end
end
