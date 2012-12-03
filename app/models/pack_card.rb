class PackCard < ActiveRecord::Base
  attr_accessible :pack, :pack_name, :card, :card_code, :amount

  belongs_to :card, foreign_key:'card_code'
  belongs_to :pack, foreign_key:'pack_name'
end
