class Card < ActiveRecord::Base
  attr_accessible :type, :code, :name, :description, :type_name, :cast_cost, :or_cost, :novice, :deck_max
  set_primary_key :code

  validates_uniqueness_of :code
  validates_presence_of :name

  has_many :school_levels, :foreign_key => "card_code"
  has_many :schools, :through => :school_levels
  has_many :trait_levels, :foreign_key => "card_code"
  has_many :traits, :through => :trait_levels
  belongs_to :type, :foreign_key => :type_name

  has_many :card_decks, :foreign_key => 'card_code'
  has_many :decks, :through => 'card_decks'

  scope :air, -> { joins(:schools).where("schools.name = 'Air'") }
  scope :arcane, -> { joins(:schools).where("schools.name = 'Arcane'") }
  scope :dark, -> { joins(:schools).where("schools.name = 'Dark'") }
  scope :earth, -> { joins(:schools).where("schools.name = 'Earth'") }
  scope :fire, -> { joins(:schools).where("schools.name = 'Fire'") }
  scope :holy, -> { joins(:schools).where("schools.name = 'Holy'") }
  scope :mind, -> { joins(:schools).where("schools.name = 'Mind'") }
  scope :nature, -> { joins(:schools).where("schools.name = 'Nature'") }
  scope :war, -> { joins(:schools).where("schools.name = 'War'") }
  scope :water, -> { joins(:schools).where("schools.name = 'Water'") }

  scope :attack, -> {where(type_name:'Attack')}
  scope :conjuration, -> {where(type_name:'Conjuration')}
  scope :creature, -> {where(type_name:'Enchantment')}
  scope :enchantment, -> {where(type_name:'Enchantment')}
  scope :equipment, -> {where(type_name:'Equipment')}
  scope :incantation, -> {where(type_name:'Incantation')}


end
