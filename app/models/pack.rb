class Pack < ActiveRecord::Base

  attr_accessible :name

  self.primary_key = 'name'

  has_many :pack_cards, :foreign_key => :pack_name
  has_many :cards, :through => :pack_cards

end
