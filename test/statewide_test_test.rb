require_relative 'test_helper'

require './lib/statewide_test'
require './lib/statewide_test_repository'

class TestStatewideTest < Minitest::Test

def setup
    name = "ACADEMY 20"
    third_grade_data =    {
                          2008=>{:math=>"0.857", :reading=>"0.866", :writing=>"0.671"},
                          2009=>{:math=>"0.824", :reading=>"0.862", :writing=>"0.706"},
                          2010=>{:math=>"0.849", :reading=>"0.864", :writing=>"0.662"},
                          2011=>{:math=>"0.819", :reading=>"0.867", :writing=>"0.678"},
                          2012=>{:reading=>"0.87", :math=>"0.83", :writing=>"0.65517"},
                          2013=>{:math=>"0.8554", :reading=>"0.85923", :writing=>"0.6687"},
                          2014=>{:math=>"0.8345", :reading=>"0.83101", :writing=>"0.63942"}
                          }

    eighth_grade_data =   {
                          2008=>{:math=>"0.64", :reading=>"0.843", :writing=>"0.734"},
                          2009=>{:math=>"0.656", :reading=>"0.825", :writing=>"0.701"},
                          2010=>{:math=>"0.672", :reading=>"0.863", :writing=>"0.754"},
                          2011=>{:reading=>"0.83221", :math=>"0.65339", :writing=>"0.74579"},
                          2012=>{:math=>"0.68197", :writing=>"0.73839", :reading=>"0.83352"},
                          2013=>{:math=>"0.6613", :reading=>"0.85286", :writing=>"0.75069"},
                          2014=>{:math=>"0.68496", :reading=>"0.827", :writing=>"0.74789"}
                          }

    math_data = {
                2011=>
                        {
                        :"all students"=>"0.68",
                        :asian=>"0.8169",
                        :black=>"0.4246",
                        :"hawaiian/pacific islander"=>"0.5686",
                        :hispanic=>"0.5681",
                        :"native american"=>"0.6143",
                        :"two or more"=>"0.6772",
                        :white=>"0.7065"
                        },
                2012=>
                        {
                        :"all students"=>"0.6894",
                        :asian=>"0.8182",
                        :black=>"0.4248",
                        :"hawaiian/pacific islander"=>"0.5714",
                        :hispanic=>"0.5722",
                        :"native american"=>"0.5714",
                        :"two or more"=>"0.6899",
                        :white=>"0.7135"
                        },
                2013=>
                        {
                        :"all students"=>"0.69683",
                        :asian=>"0.8053",
                        :black=>"0.4404",
                        :"hawaiian/pacific islander"=>"0.6833",
                        :hispanic=>"0.5883",
                        :"native american"=>"0.5932",
                        :"two or more"=>"0.6967",
                        :white=>"0.7208"
                        },
                2014=>
                        {
                        :"all students"=>"0.69944",
                        :asian=>"0.8",
                        :black=>"0.4205",
                        :"hawaiian/pacific islander"=>"0.6818",
                        :hispanic=>"0.6048",
                        :"native american"=>"0.5439",
                        :"two or more"=>"0.6932",
                        :white=>"0.723"
                      }
                }

    reading_data =  {
                    2011=>
                          {
                          :"all students"=>"0.83",
                          :asian=>"0.8976",
                          :black=>"0.662",
                          :"hawaiian/pacific islander"=>"0.7451",
                          :hispanic=>"0.7486",
                          :"native american"=>"0.8169",
                          :"two or more"=>"0.8419",
                          :white=>"0.8513"
                          },
                    2012=>
                          {
                          :"all students"=>"0.84585",
                          :asian=>"0.89328",
                          :black=>"0.69469",
                          :"hawaiian/pacific islander"=>"0.83333",
                          :hispanic=>"0.77167",
                          :"native american"=>"0.78571",
                          :"two or more"=>"0.84584",
                          :white=>"0.86189"
                          },
                    2013=>
                          {
                          :"all students"=>"0.84505",
                          :asian=>"0.90193",
                          :black=>"0.66951",
                          :"hawaiian/pacific islander"=>"0.86667",
                          :hispanic=>"0.77278",
                          :"native american"=>"0.81356",
                          :"two or more"=>"0.85582",
                          :white=>"0.86083"
                          },
                    2014=>
                          {
                          :"all students"=>"0.84127",
                          :asian=>"0.85531",
                          :black=>"0.70387",
                          :"hawaiian/pacific islander"=>"0.93182",
                          :hispanic=>"0.00778",
                          :"native american"=>"0.00724",
                          :"two or more"=>"0.00859",
                          :white=>"0.00856"}
                          }

    writing_data =  {
                    2011=>
                          {
                          :"all students"=>"0.7192",
                          :asian=>"0.8268",
                          :black=>"0.5152",
                          :"hawaiian/pacific islander"=>"0.7255",
                          :hispanic=>"0.6068",
                          :"native american"=>"0.6",
                          :"two or more"=>"0.7274",
                          :white=>"0.7401"
                          },
                    2012=>
                          {
                          :"all students"=>"0.70593",
                          :asian=>"0.8083",
                          :black=>"0.5044",
                          :"hawaiian/pacific islander"=>"0.6833",
                          :hispanic=>"0.5978",
                          :"native american"=>"0.5893",
                          :"two or more"=>"0.7186",
                          :white=>"0.7262"
                          },
                    2013=>
                          {
                          :"all students"=>"0.72029",
                          :asian=>"0.8109",
                          :black=>"0.4819",
                          :"hawaiian/pacific islander"=>"0.7167",
                          :hispanic=>"0.623",
                          :"native american"=>"0.6102",
                          :"two or more"=>"0.7474",
                          :white=>"0.7406"
                          },
                    2014=>
                          {
                          :"all students"=>"0.71583",
                          :asian=>"0.7894",
                          :black=>"0.5194",
                          :"hawaiian/pacific islander"=>"0.7273",
                          :hispanic=>"0.6244",
                          :"native american"=>"0.6207",
                          :"two or more"=>"0.7317",
                          :white=>"0.7348"
                          }
                    }
    @sw = StatewideTest.new({
                            :name => name.upcase,
                            :third_grade_data => third_grade_data,
                            :eighth_grade_data => eighth_grade_data,
                            :math_data => math_data,
                            :reading_data => reading_data,
                            :writing_data => writing_data
                              })
  end

  def test_it_exists
    assert_instance_of StatewideTest, @sw
  end

  def test_proficient_by_grade
    assert_instance_of Hash, @sw.proficient_by_grade(3)
    expected = {
            2008=>{:math=>0.857, :reading=>0.866, :writing=>0.671},
            2009=>{:math=>0.824, :reading=>0.862, :writing=>0.706},
            2010=>{:math=>0.849, :reading=>0.864, :writing=>0.662},
            2011=>{:math=>0.819, :reading=>0.867, :writing=>0.678},
            2012=>{:reading=>0.87, :math=>0.83, :writing=>0.655},
            2013=>{:math=>0.855, :reading=>0.859, :writing=>0.668},
            2014=>{:math=>0.834, :reading=>0.831, :writing=>0.639}
          }

    assert_equal expected, @sw.proficient_by_grade(3)

    assert_raises(UnknownDataError) do
      @sw.proficient_by_grade(1)
    end
  end

  def test_proficient_by_race_or_ethnicity
    output = @sw.proficient_by_race_or_ethnicity(:asian)
    expected = {:math=>0.816, :reading=>0.897, :writing=>0.826}
    
    assert_equal expected, output[2011]
  end

  def test_proficient_for_subject_by_grade_in_year
    output = @sw.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
    assert_equal 0.857, output

    output_2 = @sw.proficient_for_subject_by_grade_in_year(:math, 8, 2008)
    assert_equal 0.64, output_2

    assert_raises(UnknownDataError) { @sw.proficient_for_subject_by_grade_in_year(:math, 1, 2008) }

    assert_raises(UnknownDataError) { @sw.proficient_for_subject_by_grade_in_year(:math, 3, "2008") }

    assert_raises(UnknownDataError) { @sw.proficient_for_subject_by_grade_in_year(:science, 3, 2008) }
    
  end
end
