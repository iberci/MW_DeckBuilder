class Card < ActiveRecord::Base
  attr_accessible :type, :code, :name, :description, :type_name
  set_primary_key :code

  validates_uniqueness_of :code

  has_many :school_levels, :foreign_key => :school
  has_many :traits, :foreign_key => :trait
  belongs_to :type, :foreign_key => :type

  accepts_nested_attributes_for :type

  validates_presence_of :name
end
