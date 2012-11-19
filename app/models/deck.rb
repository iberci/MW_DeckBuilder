class Deck < ActiveRecord::Base
  attr_accessible :name

  set_primary_key :name

  has_many :card_decks, :foreign_key => 'deck_name'
  has_many :cards, :through => :card_decks

end
