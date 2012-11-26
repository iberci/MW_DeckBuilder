class SchoolLevel < ActiveRecord::Base

  attr_accessible :school, :level, :card_code, :card, :school_name

  belongs_to :school, :foreign_key => 'school_name'
  belongs_to :card, :foreign_key => 'card_code'
end
