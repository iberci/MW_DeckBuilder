# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

creature, enchantment, conjuration, incantation, attack, equipment = *Type.create([
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

###################### Cards ###################################

def  create_card(code, type, name, schools, cast_cost, traits = {}) 
  puts code
  c = Card.create(code:code.upcase, type_name:type.capitalize, name:name, cast_cost:cast_cost)

  schools.each do |school, level|
    c.school_levels.create(school:School.find(school.to_s.capitalize), level:level)
  end

  traits.each do |name, level|
    t = Trait.find_or_create(name:name)
    c.trait_levels.create(trait:t, level:level)
  end
  c
end

# Attack
[
  %w{mw1a01 attack} << 'Blinding Flash' << {holy:2} << 7,
  %w{mw1a02 attack} << 'Chain Lightning' << {air:3} << 12,
  %w{mw1a03 attack Electrify} << {air:2} << 9,
  %w{mw1a04 attack Fireball} << {fire:2} << 8,
  %w{mw1a05 attack Firestorm} << {fire:3} << 11,
  %w{mw1a06 attack Flameblast} << {fire:1} << 5,
  %w{mw1a07 attack} << 'Lightning Bolt' << {air:2} << 8, 
  %w{mw1a08 attack Geyser} << {water:1} << 4,
  %w{mw1a09 attack} << 'Jet Stream' << {air:1} << 4,
  %w{mw1a11 attack} << 'Pillar of Light' << {holy:1} << 5,
  %w{mw1a12 attack} << 'Ring of Fire' << {fire:2} << 9,
  %w{mw1a13 attack Thunderbolt} << {air:3} << 10
].each { |p| create_card(*p)} 

#Enchantment
[
  %w{mw1e01 enchantment} << 'Bear Strength' << {nature:1} << 3,
  %w{mw1e02 enchantment Block} << {mind:1} << 2,
  %w{mw1e03 enchantment} << 'Bull Endurance' << {nature:1} << 3,
  %w{mw1e04 enchantment} << 'Chains of Agony' << {dark:1} << 1,
  %w{mw1e05 enchantment} << 'Cheetah Speed' << {nature:1} << 3,
  %w{mw1e06 enchantment} << 'Circle of Lightning' << {air:2} << 4,
  %w{mw1e07 enchantment} << 'Cobra Reflexes' << {nature:2} << 5,
  %w{mw1e08 enchantment} << 'Death Link' << {dark:2} << 6,
  %w{mw1e09 enchantment Agony} << {dark:1} << 3,
  %w{mw1e10 enchantment Decoy} << {mind:1} << 2,
  %w{mw1e11 enchantment} << 'Divine Intervention' << {holy:3} << 10,
  %w{mw1e12 enchantment} << 'Divine Protection' << {holy:1} << 2,
  %w{mw1e13 enchantment} << 'Eagle Wings' << {nature:2} << 4,
  %w{mw1e14 enchantment Enfeeble} << {dark:2} << 4,
  %w{mw1e15 enchantment} << 'Essence Drain' << {arcane:2} << 4,
  %w{mw1e16 enchantment} << 'Force Hold' << {mind:2} << 2,
  %w{mw1e17 enchantment} << 'Force Orb' << {mind:1} << 3,
  %w{mw1e18 enchantment} << 'Force Sword' << {mind:1} << 3,
  %w{mw1e19 enchantment} << 'Ghoul Rot' << {dark:2} << 4,
  %w{mw1e20 enchantment Harmonize} << {arcane:1} << 2,
  %w{mw1e21 enchantment Hawkeye} << {nature:1} << 1,
  %w{mw1e22 enchantment} << 'Hellfire Trap' << {dark:1} << 2,
  %w{mw1e23 enchantment Jinx} << {arcane:1} << 1,
  %w{mw1e24 enchantment Magebane} << {arcane:1} << 3,
  %w{mw1e25 enchantment} << 'Maim Wings' << {dark:1} << 3,
  %w{mw1e27 enchantment} << 'Marked for Death' << {dark:1} << 2,
  %w{mw1e28 enchantment} << 'Mongoose Agility' << {nature:1} << 3,
  %w{mw1e29 enchantment Nullify} << {arcane:1} << 2,
  %w{mw1e30 enchantment Pacify} << {holy:1} << 2,
  %w{mw1e31 enchantment} << 'Poisoned Blood' << {dark:1} << 3,
  %w{mw1e32 enchantment Regrowth} << {nature:1} << 3,
  %w{mw1e33 enchantment Retaliate} << {war:1} << 2,
  %w{mw1e34 enchantment} << 'Reverse Attack' << {mind:2} << 5,
  %w{mw1e35 enchantment} << 'Reverse Magic' << {arcane:2} << 5,
  %w{mw1e36 enchantment} << 'Rhino Hide' << {nature:1} << 2,
  %w{mw1e37 enchantment} << 'Sacred Ground' << {holy:2} << 4,
  %w{mw1e38 enchantment} << 'Teleport Trap' << {arcane:1} << 2,
  %w{mw1e39 enchantment} << 'Turn to Stone' << {arcane:2} << 4,
  %w{mw1e40 enchantment Vampirism} << {dark:2} << 4,
].each { |p| create_card(*p)} 
