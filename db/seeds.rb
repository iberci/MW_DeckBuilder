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

wizard_air, wizard_water, wizard_earth, wizard_fire, priestess, beastmaster, sorcerer = *Mage.create([
  {name:'Wizard(Air)'},
  {name:'Wizard(Water)'},
  {name:'Wizard(Earth)'},
  {name:'Wizard(Fire)'},
  {name:'Priestess'},
  {name:'Beastmaster'},
  {name:'Sorcerer'}
])

wizard_air.mage_schools.create!(school:arcane, cost:1)
wizard_air.mage_schools.create!(school:air, cost:1)
wizard_air.mage_schools.create!(school:earth, cost:2)
wizard_air.mage_schools.create!(school:water, cost:2)
wizard_air.mage_schools.create!(school:fire, cost:2)

wizard_water.mage_schools.create!(school:arcane, cost:1)
wizard_water.mage_schools.create!(school:air, cost:2)
wizard_water.mage_schools.create!(school:earth, cost:2)
wizard_water.mage_schools.create!(school:water, cost:1)
wizard_water.mage_schools.create!(school:fire, cost:2)

priestess.mage_schools.create!(school:air, cost:2)
priestess.mage_schools.create!(school:dark, cost:3)
