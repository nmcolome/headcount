require 'csv'
require_relative 'data_row'

class DataTable
  attr_reader :filename_path, :contents

  def initialize(filename_path)
    @filename_path = filename_path
    @contents = get_contents
  end

  def get_contents
    contents = CSV.open(filename_path, headers: true, header_converters: :symbol)
    contents.map do |row|
      DataRow.new(row)
    end
  end

  def district
    contents.map do |row|
      row.district
    end
  end
  
end