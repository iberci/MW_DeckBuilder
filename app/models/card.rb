class Card < ActiveRecord::Base
  attr_accessible :type, :code, :name, :description, :type_name, :cast_cost, :or_cost, :novice, :deck_max
  self.primary_key = 'code'

  validates_uniqueness_of :code
  validates_presence_of :name

  has_many :school_levels, :foreign_key => "card_code"
  has_many :schools, :through => :school_levels
  has_many :trait_levels, :foreign_key => "card_code"
  has_many :traits, :through => :trait_levels
  belongs_to :type, :foreign_key => :type_name

  has_many :pack_cards, :foreign_key => :card_code
  has_many :packs, :through => :pack_cards

  has_many :deck_cards, :foreign_key => :card_code
  has_many :decks, :through => :deck_cards

  scope :for_schools, ->(*s) {
    joins(:schools).where("schools.name in (?)", s.flatten.reject(&:blank?).map{|sc| sc.to_s.capitalize})
  }
  scope :for_school, ->(*s) {for_schools(*s)}

  scope :for_types, ->(*t) {
    where("cards.type_name in (?)", t.flatten.reject(&:blank?).map{|ty|ty.to_s.capitalize})
  }
  scope :for_type, ->(*t) {for_types(*t)}

end
