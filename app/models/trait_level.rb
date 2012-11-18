class TraitLevel < ActiveRecord::Base

  set_primary_keys 'card_code', 'trait_name'
  belongs_to :trait, :foreign_key => 'trait_name'
  belongs_to :card, :foreign_key => 'card_code'

  validates_presence_of 'level'
end
