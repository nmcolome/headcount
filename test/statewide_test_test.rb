require_relative 'test_helper'

require './lib/statewide_test'
require './lib/statewide_test_repository'

class TestStatewideTest < Minitest::Test

  def test_it_exists
    sw = StatewideTest.new({:name => "ACADEMY 20"})

    assert_instance_of StatewideTest, sw
  end
end
