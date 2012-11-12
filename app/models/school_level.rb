class SchoolLevel < ActiveRecord::Base

  self.primary_keys :card_id, :school_id
  attr_accessible :cost, :school, :card
  belongs_to :school
  belongs_to :card
end
