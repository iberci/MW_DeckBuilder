class SchoolLevel < ActiveRecord::Base

  self.primary_keys :card_id, :school_id
  attr_protected :id
  belongs_to :school
  belongs_to :card
end
