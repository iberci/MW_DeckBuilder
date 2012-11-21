class Mage < ActiveRecord::Base
  attr_accessible :name
  
  self.primary_key = 'name'
  has_many :mage_schools, foreign_key:'mage_name'
  has_many :schools, :through => :mage_schools
end
