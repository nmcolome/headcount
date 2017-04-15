require 'csv'
require_relative 'data_row'
require 'pry'

class DataTable
  attr_reader :filename_path, :contents

  def initialize(filename_path)
    @filename_path = filename_path
    @contents = get_contents
  end

  def get_contents
    contents = CSV.open(filename_path,
                        headers: true,
                        header_converters: :symbol)
    contents.map do |row|
      DataRow.new(row)
    end
  end

  def district
    contents.map do |row|
      row.district
    end
  end

  # def district_participation
  #   participation_by_district.map do |collection|
  #     year_data = collection[1]
  #     year_data = year_data.reduce({}, :merge)
  #     [collection[0], year_data]
  #   end
  # end

  # def all_participation_data
  #   contents.map do |row|
  #     [row.district, {row.year.to_i => row.data_value[0..4].to_f}]
  #   end
  # end

  # def participation_by_district
  #   district.uniq.map do |district|
  #     year_data = all_participation_data.map do |set|
  #       if set.first == district
  #         set[1]
  #       end
  #     end
  #     [district, year_data.compact]
  #   end
  # end
end

