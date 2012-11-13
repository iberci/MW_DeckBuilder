class Mage < ActiveRecord::Base
  attr_protected :id

  has_many :mage_schools
  has_many :schools, :through => :mage_schools
end
