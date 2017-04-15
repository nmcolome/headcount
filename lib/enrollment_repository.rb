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
    Enrollment.new({:name => district_name,
                    :kindergarten_participation => get_kindergarten_participation(district_name)
                  })
  end

  def get_kindergarten_participation(district_name)
    kinder_participation = district_participation.select do |district|
      district.first.upcase == district_name.upcase
    end
    kinder_participation.flatten.last
  end

  def district
    @data_set[:enrollment][:kindergarten].contents.map do |row|
      row.district
    end
  end

  def district_participation
    participation_by_district.map do |collection|
      year_data = collection[1]
      year_data = year_data.reduce({}, :merge)
      [collection[0], year_data]
    end
  end

  def participation_by_district
    district.uniq.map do |district|
      year_data = all_participation_data.map do |set|
        if set.first == district
          set[1]
        end
      end
      [district, year_data.compact]
    end
  end

  def all_participation_data
    @data_set[:enrollment][:kindergarten].contents.map do |row|
      [row.district, {row.year.to_i => row.data_value[0..4].to_f}]
    end
  end
end
