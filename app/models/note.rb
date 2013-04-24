class Note < ActiveRecord::Base
  attr_accessible *column_names
  self.inheritance_column = nil
end
