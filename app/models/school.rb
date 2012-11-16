class School < ActiveRecord::Base
  attr_accessible :name
  set_primary_key :name

end
