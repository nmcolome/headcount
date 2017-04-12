require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/district.rb'

class TestDistrict < Minitest::Test

  def test_if_it_exists
    d = District.new({:name => "ACADEMY 20"})
    assert_instance_of District, d
    assert_equal "ACADEMY 20", d.name
  end

end
