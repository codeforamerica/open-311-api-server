class Request < ActiveRecord::Base
  #eval("attr_accessible #{column_names.map { |cn| cn.to_sym }.to_s.gsub(/\[|\]/,"")}")
  attr_accessible *column_names
  has_many :notes
end
