require_relative 'repository_module'
require_relative 'enrollment'
require_relative 'data_table'
require 'csv'
require 'pry'

class EnrollmentRepository
  include Repository

  attr_reader :data_set

  def get_data_set(data_set)
      @data_set = data_set
  end

  def new_instance(district_name)
    # binding.pry
    Enrollment.new({:name => district_name,
                    :kindergarten_participation => get_kindergarten_participation(district_name),
                    :high_school_graduation => get_graduation_rate(district_name)
                  })
  end

  def get_kindergarten_participation(district_name)
    return nil if @data_set[:enrollment][:kindergarten].nil?
    kinder_participation = district_participation(:enrollment, :kindergarten).select do |district|
      district.first.upcase == district_name.upcase
    end
    kinder_participation.flatten.last
  end

  def get_graduation_rate(district_name)
    return nil if @data_set[:enrollment][:high_school_graduation].nil?
    graduation_rate = district_participation(:enrollment, :high_school_graduation).select do |district|
      district.first.upcase == district_name.upcase
    end
    graduation_rate.flatten.last
  end

  def find_district(category, file_object)
    @data_set[category][file_object].contents.map do |row|
      row.district
    end
  end

  def district_participation(category, file_object)
    participation_by_district(category, file_object).map do |collection|
      year_data = collection[1]
      year_data = year_data.reduce({}, :merge)
      [collection[0], year_data]
    end
  end

  def participation_by_district(category, file_object)
    find_district(category, file_object).uniq.map do |district|
      year_data = all_participation_data(category, file_object).map do |set|
        if set.first == district
          set[1]
        end
      end
      [district, year_data.compact]
    end
  end

  def all_participation_data(category, file_object)
    @data_set[category][file_object].contents.map do |row|
      [row.district, {row.year.to_i => row.data_value[0..4].to_f}]
    end
  end
end
