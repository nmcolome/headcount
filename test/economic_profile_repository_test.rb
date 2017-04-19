require_relative 'test_helper'

require './lib/economic_profile_repository'

class TestEconomicProfileRepository < Minitest::Test

  def test_it_exists
    epr = EconomicProfileRepository.new
    assert_instance_of EconomicProfileRepository, epr
  end
  
end