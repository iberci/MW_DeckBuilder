class DeckCard < ActiveRecord::Base
  set_primary_keys :deck_id, :card_code
  attr_accessible :deck, :deck_id, :card, :card_code, :amount

  belongs_to :card, foreign_key:'card_code'
  belongs_to :deck
end
