class SchoolLevel < ActiveRecord::Base

  attr_protected
  self.primary_keys :card_id, :school_id
  belongs_to :school
  belongs_to :card
end
