class Card < ActiveRecord::Base
  attr_accessible :name, :type

  has_many :school_levels
  belongs_to :type
end
