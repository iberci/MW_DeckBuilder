class Card < ActiveRecord::Base
  attr_protected
  set_primary_key :code

  has_many :school_levels
  belongs_to :type, :foreign_key => :type

  validates_presence_of :name
end
