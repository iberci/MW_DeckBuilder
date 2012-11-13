class MageSchool < ActiveRecord::Base
  attr_protected 
  set_primary_keys :mage_id, :school_id

  belongs_to :mage
  belongs_to :school

end
