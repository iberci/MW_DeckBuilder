class School < ActiveRecord::Base
  self.primary_key = 'name'
  attr_accessible :name

end
