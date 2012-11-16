class MageSchool < ActiveRecord::Base
  attr_accessible :cost, :school, :mage 
  set_primary_keys :mage_name, :school_name

  belongs_to :mage, foreign_key:'mage_name'
  belongs_to :school, foreign_key:'school_name'

end
