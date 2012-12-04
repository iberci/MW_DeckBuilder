module CardsHelper
  def flatten_card(card)
    card.attributes.merge(:levels => card.school_levels.map(&:attributes), :packs => card.pack_cards.map(&:attributes))
  end

  def flatten_cards(cards)
    cards.map { |card| flatten_card(card)}
  end

  def flatten_deck(deck)
    deck.attributes.merge(
      :deck_cards => deck.deck_cards.map do |dc|
        {:card => flatten_card(dc.card), :amount => dc.amount}
      end)
  end

end
