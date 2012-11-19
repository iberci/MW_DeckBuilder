class CardDeck < ActiveRecord::Base
  attr_accessible :deck_name, :card_cost, :deck, :card, :amount 

  belongs_to :card, foreign_key:'card_code'
  belongs_to :deck, foreign_key:'deck_name'
end
