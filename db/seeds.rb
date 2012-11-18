# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

Type.create([
  {name:'Creature'},
  {name:'Enchantment'},
  {name:'Conjuration'},
  {name:'Incantation'},
  {name:'Attack'},
  {name:'Equipment'}
])

air, arcane, dark, earth, fire, holy, mind, nature, war, water = *School.create([
  {name:'Air'},
  {name:'Arcane'},
  {name:'Dark'},
  {name:'Earth'},
  {name:'Fire'},
  {name:'Holy'},
  {name:'Mind'},
  {name:'Nature'},
  {name:'War'},
  {name:'Water'}
])

wizard_air, wizard_water, wizard_earth, wizard_fire, priestess, beastmaster, warlock = *Mage.create([
  {name:'Wizard(Air)'},
  {name:'Wizard(Water)'},
  {name:'Wizard(Earth)'},
  {name:'Wizard(Fire)'},
  {name:'Priestess'},
  {name:'Beastmaster'},
  {name:'Warlock'}
])

# Air Wizard
{ air => 1, arcane => 1, dark => 2, earth => 2, fire => 2, 
  holy => 2, mind => 2, nature => 2, war => 2, water => 2, fire => 2
}.each do  |school, cost|
  wizard_air.mage_schools.create!(school:school, cost:cost)
end

# Water Wizard
{ air => 2, arcane => 1, dark => 2, earth => 2, fire => 2, 
  holy => 2, mind => 2, nature => 2, war => 2, water => 1, fire => 2
}.each do  |school, cost|
  wizard_water.mage_schools.create!(school:school, cost:cost)
end

# Earth Wizard
{ air => 2, arcane => 1, dark => 2, earth => 1, fire => 2, 
  holy => 2, mind => 2, nature => 2, war => 2, water => 2, fire => 2
}.each do  |school, cost|
  wizard_earth.mage_schools.create!(school:school, cost:cost)
end

# Fire Wizard
{ air => 2, arcane => 1, dark => 2, earth => 2, fire => 1, 
  holy => 2, mind => 2, nature => 2, war => 2, water => 2, fire => 2
}.each do  |school, cost|
  wizard_fire.mage_schools.create!(school:school, cost:cost)
end

# Priestess
{ air => 2, arcane => 2, dark => 3, earth => 2, fire => 2, 
  holy => 1, mind => 2, nature => 2, war => 2, water => 2, fire => 2
}.each do  |school, cost|
  priestess.mage_schools.create!(school:school, cost:cost)
end

# Beastmaster
{ air => 2, arcane => 2, dark => 2, earth => 2, fire => 3, 
  holy => 2, mind => 2, nature => 1, war => 2, water => 2, fire => 2
}.each do  |school, cost|
  beastmaster.mage_schools.create!(school:school, cost:cost)
end

# Warlock
{ air => 2, arcane => 2, dark => 1, earth => 2, fire => 1, 
  holy => 3, mind => 2, nature => 2, war => 2, water => 2, fire => 2
}.each do  |school, cost|
  warlock.mage_schools.create!(school:school, cost:cost)
end

