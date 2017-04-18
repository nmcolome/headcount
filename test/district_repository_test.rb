require_relative 'test_helper'

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
        :kindergarten => "./test/fixtures/k_5lines.csv",
        :high_school_graduation => "./test/fixtures/hs_5lines.csv",
      },
      :statewide_testing => {
        :third_grade => "./test/fixtures/third_5lines.csv",
        :eighth_grade => "./test/fixtures/eighth_5lines.csv",
        :math => "./test/fixtures/math_5lines.csv",
        :reading => "./test/fixtures/reading_5lines.csv",
        :writing => "./test/fixtures/writing_5lines.csv"
      }
    })

    assert_equal Hash, data.class
  end

  def test_access_to_districts
    dr = DistrictRepository.new
    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/k_5lines.csv",
        :high_school_graduation => "./test/fixtures/hs_5lines.csv",
      },
      :statewide_testing => {
        :third_grade => "./test/fixtures/third_5lines.csv",
        :eighth_grade => "./test/fixtures/eighth_5lines.csv",
        :math => "./test/fixtures/math_5lines.csv",
        :reading => "./test/fixtures/reading_5lines.csv",
        :writing => "./test/fixtures/writing_5lines.csv"
      }
    })

    assert_equal Hash, dr.districts.class
    assert_equal District, dr.districts["COLORADO"].class
  end

  def test_find_by_name_can_return_nil
    dr = DistrictRepository.new
    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/k_5lines.csv",
        :high_school_graduation => "./test/fixtures/hs_5lines.csv",
      },
      :statewide_testing => {
        :third_grade => "./test/fixtures/third_5lines.csv",
        :eighth_grade => "./test/fixtures/eighth_5lines.csv",
        :math => "./test/fixtures/math_5lines.csv",
        :reading => "./test/fixtures/reading_5lines.csv",
        :writing => "./test/fixtures/writing_5lines.csv"
      }
    })

    district_2 = dr.find_by_name("UNLIKELY NAME")
    
    assert_nil district_2
  end

  def test_find_by_name_can_return_district_instance
    dr = DistrictRepository.new
    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/k_5lines.csv",
        :high_school_graduation => "./test/fixtures/hs_5lines.csv",
      },
      :statewide_testing => {
        :third_grade => "./test/fixtures/third_5lines.csv",
        :eighth_grade => "./test/fixtures/eighth_5lines.csv",
        :math => "./test/fixtures/math_5lines.csv",
        :reading => "./test/fixtures/reading_5lines.csv",
        :writing => "./test/fixtures/writing_5lines.csv"
      }
    })

    district = dr.find_by_name("ACADEMY 20")
    assert_equal District, district.class
  end

  def test_find_by_name_can_return_district_instance_with_lowercase_argument
    dr = DistrictRepository.new
    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/k_5lines.csv",
        :high_school_graduation => "./test/fixtures/hs_5lines.csv",
      },
      :statewide_testing => {
        :third_grade => "./test/fixtures/third_5lines.csv",
        :eighth_grade => "./test/fixtures/eighth_5lines.csv",
        :math => "./test/fixtures/math_5lines.csv",
        :reading => "./test/fixtures/reading_5lines.csv",
        :writing => "./test/fixtures/writing_5lines.csv"
      }
    })

    district_3 = dr.find_by_name("academy 20")
    
    assert_equal District, district_3.class
  end

  def test_find_all_matching_can_return_empty_array
    dr = DistrictRepository.new
    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/k_5lines.csv",
        :high_school_graduation => "./test/fixtures/hs_5lines.csv",
      },
      :statewide_testing => {
        :third_grade => "./test/fixtures/third_5lines.csv",
        :eighth_grade => "./test/fixtures/eighth_5lines.csv",
        :math => "./test/fixtures/math_5lines.csv",
        :reading => "./test/fixtures/reading_5lines.csv",
        :writing => "./test/fixtures/writing_5lines.csv"
      }
    })
    matching_districts = dr.find_all_matching("XXXXXIRJL")

    assert_equal [], matching_districts
  end
  
  def test_find_all_matching_returns_all_district_names
    dr = DistrictRepository.new
    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/k_5lines.csv",
        :high_school_graduation => "./test/fixtures/hs_5lines.csv",
      },
      :statewide_testing => {
        :third_grade => "./test/fixtures/third_5lines.csv",
        :eighth_grade => "./test/fixtures/eighth_5lines.csv",
        :math => "./test/fixtures/math_5lines.csv",
        :reading => "./test/fixtures/reading_5lines.csv",
        :writing => "./test/fixtures/writing_5lines.csv"
      }
    })
    matching_districts = dr.find_all_matching("CO")

    assert_equal 2, matching_districts.count
  end

  def test_automatic_creation_of_enrollment_repository
    dr = DistrictRepository.new
    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/k_5lines.csv",
        :high_school_graduation => "./test/fixtures/hs_5lines.csv",
      },
      :statewide_testing => {
        :third_grade => "./test/fixtures/third_5lines.csv",
        :eighth_grade => "./test/fixtures/eighth_5lines.csv",
        :math => "./test/fixtures/math_5lines.csv",
        :reading => "./test/fixtures/reading_5lines.csv",
        :writing => "./test/fixtures/writing_5lines.csv"
      }
    })
    assert_instance_of EnrollmentRepository, dr.enrollment_repository
  end

  def test_district_can_create_new_enrollment_object
    dr = DistrictRepository.new
    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/k_5lines.csv",
        :high_school_graduation => "./test/fixtures/hs_5lines.csv",
      },
      :statewide_testing => {
        :third_grade => "./test/fixtures/third_5lines.csv",
        :eighth_grade => "./test/fixtures/eighth_5lines.csv",
        :math => "./test/fixtures/math_5lines.csv",
        :reading => "./test/fixtures/reading_5lines.csv",
        :writing => "./test/fixtures/writing_5lines.csv"
      }
    })

    district = dr.find_by_name("ACADEMY 20")

    assert_equal Enrollment, district.enrollment.class
  end

  def test_district_can_access_kindergarten_participation_in_year
    dr = DistrictRepository.new
    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/academy_k.csv",
        :high_school_graduation => "./test/fixtures/hs_5lines.csv",
      },
      :statewide_testing => {
        :third_grade => "./test/fixtures/third_5lines.csv",
        :eighth_grade => "./test/fixtures/eighth_5lines.csv",
        :math => "./test/fixtures/math_5lines.csv",
        :reading => "./test/fixtures/reading_5lines.csv",
        :writing => "./test/fixtures/writing_5lines.csv"
      }
    })

    district = dr.find_by_name("ACADEMY 20")

    output = district.enrollment.kindergarten_participation_in_year(2010)
    assert_equal 0.436, output
  end

  def test_district_can_access_kindergarten_participation_by_year
    dr = DistrictRepository.new
    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/academy_k.csv",
        :high_school_graduation => "./test/fixtures/hs_5lines.csv",
      },
      :statewide_testing => {
        :third_grade => "./test/fixtures/third_5lines.csv",
        :eighth_grade => "./test/fixtures/eighth_5lines.csv",
        :math => "./test/fixtures/math_5lines.csv",
        :reading => "./test/fixtures/reading_5lines.csv",
        :writing => "./test/fixtures/writing_5lines.csv"
      }
    })

    district = dr.find_by_name("ACADEMY 20")

    output = district.enrollment.kindergarten_participation_by_year
    assert_equal Hash, output.class
  end

  def test_load_data_creates_hash_of_every_file
    dr = DistrictRepository.new
    l_data = dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/k_5lines.csv",
        :high_school_graduation => "./test/fixtures/hs_5lines.csv",
      },
      :statewide_testing => {
        :third_grade => "./test/fixtures/third_5lines.csv",
        :eighth_grade => "./test/fixtures/eighth_5lines.csv",
        :math => "./test/fixtures/math_5lines.csv",
        :reading => "./test/fixtures/reading_5lines.csv",
        :writing => "./test/fixtures/writing_5lines.csv"
      }
    })

    assert_equal CSV, l_data[:enrollment][:high_school_graduation].class
  end

  def test_district_can_access_proficient_for_subject_by_grade_in_year
    dr = DistrictRepository.new
    data = dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/academy_third.csv",
        :high_school_graduation => "./test/fixtures/hs_5lines.csv",
      },
      :statewide_testing => {
        :third_grade => "./test/fixtures/third_5lines.csv",
        :eighth_grade => "./test/fixtures/eighth_5lines.csv",
        :math => "./test/fixtures/math_5lines.csv",
        :reading => "./test/fixtures/reading_5lines.csv",
        :writing => "./test/fixtures/writing_5lines.csv"
      }
    })

    district = dr.find_by_name("ACADEMY 20")

    output = district.statewide_test.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
    assert_equal 0.857, output
  end

end