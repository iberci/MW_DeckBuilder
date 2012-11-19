class Card < ActiveRecord::Base
  attr_accessible :type, :code, :name, :description, :type_name, :cast_cost, :or_cost, :novice
  set_primary_key :code

  validates_uniqueness_of :code
  validates_presence_of :name, :cast_cost

  has_many :school_levels, :foreign_key => "card_code"
  has_many :schools, :through => 'school_levels'
  has_many :trait_levels, :foreign_key => "card_code"
  has_many :traits, :through => :trait_levels
  belongs_to :type, :foreign_key => :type_name

  has_many :card_decks, :foreign_key => 'card_code'
  has_many :decks, :through => 'card_decks'

end
