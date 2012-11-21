class Deck < ActiveRecord::Base
  attr_accessible :name

  self.primary_key = 'name'

  has_many :card_decks, :foreign_key => 'deck_name'
  has_many :cards, :through => :card_decks

end
