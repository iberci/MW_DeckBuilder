class TraitLevel < ActiveRecord::Base
  attr_accessible :card_code, :trait_name, :card, :trait, :level

  belongs_to :trait, :foreign_key => 'trait_name'
  belongs_to :card, :foreign_key => 'card_code'

  validates_presence_of 'level'
end
