require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/district_repository'

class TestDistrictRepository < Minitest::Test
  
  def test_it_exists
    dr = DistrictRepository.new

    assert_instance_of DistrictRepository, dr
  end

  def test_it_loads_data
    dr = DistrictRepository.new

    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })

    assert_equal CSV, data.class
  end
end