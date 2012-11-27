# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#



[Deck, TraitLevel, SchoolLevel, MageSchool, School, Mage, Card, Trait, Type].each {|k| k.send(:destroy_all)}

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
  holy => 2, mind => 2, nature => 2, war => 2, water => 2
}.each do  |school, cost|
  wizard_air.mage_schools.create!(school:school, cost:cost)
end

# Water Wizard
{ air => 2, arcane => 1, dark => 2, earth => 2, fire => 2, 
  holy => 2, mind => 2, nature => 2, war => 2, water => 1
}.each do  |school, cost|
  wizard_water.mage_schools.create!(school:school, cost:cost)
end

# Earth Wizard
{ air => 2, arcane => 1, dark => 2, earth => 1, fire => 2, 
  holy => 2, mind => 2, nature => 2, war => 2, water => 2
}.each do  |school, cost|
  wizard_earth.mage_schools.create!(school:school, cost:cost)
end

# Fire Wizard
{ air => 2, arcane => 1, dark => 2, earth => 2, fire => 1, 
  holy => 2, mind => 2, nature => 2, war => 2, water => 2
}.each do  |school, cost|
  wizard_fire.mage_schools.create!(school:school, cost:cost)
end

# Priestess
{ air => 2, arcane => 2, dark => 3, earth => 2, fire => 2, 
  holy => 1, mind => 2, nature => 2, war => 2, water => 2
}.each do  |school, cost|
  priestess.mage_schools.create!(school:school, cost:cost)
end

# Beastmaster
{ air => 2, arcane => 2, dark => 2, earth => 2, fire => 3, 
  holy => 2, mind => 2, nature => 1, war => 2, water => 2
}.each do  |school, cost|
  beastmaster.mage_schools.create!(school:school, cost:cost)
end

# Warlock
{ air => 2, arcane => 2, dark => 1, earth => 2, fire => 1, 
  holy => 3, mind => 2, nature => 2, war => 2, water => 2
}.each do  |school, cost|
  warlock.mage_schools.create!(school:school, cost:cost)
end

core = Deck.create(:name => 'Core')
tome = Deck.create(:name => 'Tome')

###################### Cards ###################################

def  create_card(code, type, name, schools, core_num, cast_cost = nil, tome_num = nil, options = {}) 
  puts code
  attributes = {
    code:code.upcase, 
    type_name:type.capitalize, 
    name:name, 
    cast_cost:cast_cost
  }.merge(options)

  attributes[:deck_max] ||= (schools.values.inject(0) {|sum, amount| sum + amount} == 1) ? 6 : 4

  c = Card.create(attributes)

  c.card_decks.create(amount:core_num, deck_name:'Core')
  if(tome_num && tome_num > 0)
    c.card_decks.create(amount:tome_num, deck_name:'Tome')
  end

  schools.each do |school, level|
    c.school_levels.create(school:School.find(school.to_s.capitalize), level:level)
  end

  c
end

# Attack
[
  ['mw1a01', 'attack', 'Blinding Flash', {holy:2}, 2, 7, 0],
  ['mw1a02', 'attack', 'Chain Lightning', {air:3}, 2, 12, 0],
  ['mw1a03', 'attack', 'Electrify', {air:2}, 2, 9, 0],
  ['mw1a04', 'attack', 'Fireball', {fire:2}, 3, 8, 1],
  ['mw1a05', 'attack', 'Firestorm', {fire:3}, 2, 11, 0],
  ['mw1a06', 'attack', 'Flameblast', {fire:1}, 2, 5, 0],
  ['mw1a07', 'attack', 'Lightning Bolt', {air:2}, 3, 8, 1], 
  ['mw1a08', 'attack', 'Geyser', {water:1}, 2, 4, 0],
  ['mw1a09', 'attack', 'Jet Stream', {air:1}, 3, 4, 1],
  ['mw1a11', 'attack', 'Pillar of Light', {holy:1}, 3, 5, 1],
  ['mw1a12', 'attack', 'Ring of Fire', {fire:2}, 2, 9, 0],
  ['mw1a13', 'attack', 'Thunderbolt', {air:3}, 2, 10, 1]
].each { |p| create_card(*p)} 

#Enchantment
[
  ['mw1e01', 'enchantment', 'Bear Strength', {nature:1}, 3, 3, 1],
  ['mw1e02', 'enchantment', 'Block', {mind:1}, 5, 2, 2],
  ['mw1e03', 'enchantment', 'Bull Endurance', {nature:1}, 2, 3, 1],
  ['mw1e04', 'enchantment', 'Chains of Agony', {dark:1}, 2, 1, 0],
  ['mw1e05', 'enchantment', 'Cheetah Speed', {nature:1}, 2, 3, 0],
  ['mw1e06', 'enchantment', 'Circle of Lightning', {air:2}, 1, 4, 1],
  ['mw1e07', 'enchantment', 'Cobra Reflexes', {nature:2}, 2, 5, 0],
  ['mw1e08', 'enchantment', 'Death Link', {dark:2}, 1, 6, 0],
  ['mw1e09', 'enchantment', 'Agony', {dark:1}, 3, 3, 1],
  ['mw1e10', 'enchantment', 'Decoy', {mind:1}, 4, 2, 1],
  ['mw1e11', 'enchantment', 'Divine Intervention', {holy:3}, 1, 10, 0, {deck_max:1}],
  ['mw1e12', 'enchantment', 'Divine Protection', {holy:1}, 2, 2, 1],
  ['mw1e13', 'enchantment', 'Eagle Wings', {nature:2}, 2, 4, 1],
  ['mw1e14', 'enchantment', 'Enfeeble', {dark:2}, 2, 4, 1],
  ['mw1e15', 'enchantment', 'Essence Drain', {arcane:2}, 3, 4, 1],
  ['mw1e16', 'enchantment', 'Force Hold', {mind:2}, 2, 2, 1],
  ['mw1e17', 'enchantment', 'Force Orb',  {mind:1}, 1,3, 1],
  ['mw1e18', 'enchantment', 'Force Sword', {mind:1}, 1, 3, 1],
  ['mw1e19', 'enchantment', 'Ghoul Rot', {dark:2}, 2, 4, 1],
  ['mw1e20', 'enchantment', 'Harmonize', {arcane:1}, 3, 2, 1],
  ['mw1e21', 'enchantment', 'Hawkeye', {nature:1}, 2, 1, 1],
  ['mw1e22', 'enchantment', 'Hellfire Trap', {dark:1}, 2, 2, 1],
  ['mw1e23', 'enchantment', 'Jinx', {arcane:1}, 2, 1, 2],
  ['mw1e24', 'enchantment', 'Magebane', {arcane:1}, 1, 3, 0],
  ['mw1e25', 'enchantment', 'Maim Wings', {dark:1}, 2, 3, 1],
  ['mw1e27', 'enchantment', 'Marked for Death', {dark:1}, 2, 2, 1],
  ['mw1e28', 'enchantment', 'Mongoose Agility', {nature:1}, 2, 3, 0],
  ['mw1e29', 'enchantment', 'Nullify', {arcane:1}, 5, 2, 2],
  ['mw1e30', 'enchantment', 'Pacify', {holy:1}, 2, 2, 1],
  ['mw1e31', 'enchantment', 'Poisoned Blood', {dark:1}, 2, 3, 1],
  ['mw1e32', 'enchantment', 'Regrowth', {nature:1}, 2, 3, 1],
  ['mw1e33', 'enchantment', 'Retaliate', {war:1}, 2, 2, 1],
  ['mw1e34', 'enchantment', 'Reverse Attack', {mind:2}, 2, 5, 1],
  ['mw1e35', 'enchantment', 'Reverse Magic', {arcane:2}, 2, 5, 1],
  ['mw1e36', 'enchantment', 'Rhino Hide', {nature:1}, 3, 2, 1],
  ['mw1e37', 'enchantment', 'Sacred Ground', {holy:2}, 2, 4, 1],
  ['mw1e38', 'enchantment', 'Teleport Trap', {arcane:1}, 2, 2, 1],
  ['mw1e39', 'enchantment', 'Turn to Stone', {arcane:2}, 2, 4, 1],
  ['mw1e40', 'enchantment', 'Vampirism', {dark:2}, 2, 4, 1]
].each { |p| create_card(*p)} 

#Incantation
[
  ['mw1i01', 'incantation', 'Banish', {arcane:3}, 2, 14, 1],
  ['mw1i02', 'incantation', 'Battle Fury', {war:1}, 2, 5, 1],
  ['mw1i03', 'incantation', 'Call of the Wild', {nature:1}, 3, 4, 1],
  ['mw1i04', 'incantation', 'Charge', {war:1}, 2, 4, 1],
  ['mw1i06', 'incantation', 'Dispel', {arcane:1}, 5, nil, 1],
  ['mw1i07', 'incantation', 'Disolve', {water:1}, 5, nil, 1],
  ['mw1i08', 'incantation', 'Drain Life', {dark:3}, 2, 12, 1],
  ['mw1i09', 'incantation', 'Drain Power', {dark:3}, 2, 16, 1],
  ['mw1i10', 'incantation', 'Evade', {war:1}, 2, 3, 1],
  ['mw1i11', 'incantation', 'Explode', {fire:2}, 2, 0, 1],
  ['mw1i12', 'incantation', 'Force Push', {mind:1}, 3, 3, 2],
  ['mw1i13', 'incantation', 'Group Heal', {holy:2}, 2, 9, 1],
  ['mw1i14', 'incantation', 'Heal', {holy:2}, 3, 9, 1],
  ['mw1i15', 'incantation', 'Knockdown', {mind:1}, 2, 3, 1],
  ['mw1i16', 'incantation', 'Lay Hands', {holy:3}, 1, 9, 0, {deck_max:1}],
  ['mw1i17', 'incantation', 'Minor Heal', {holy:1}, 5, 5, 1],
  ['mw1i18', 'incantation', 'Perfect Strike', {war:1}, 2, 2, 1, {novice:true}],
  ['mw1i19', 'incantation', 'Piercing Strike', {war:1}, 2, 2, 1,{novice:true}],
  ['mw1i20', 'incantation', 'Purify', {holy:1}, 1, nil, 1],
  ['mw1i21', 'incantation', 'Purge Magic', {arcane:3}, 2, 12, 1],
  ['mw1i22', 'incantation', 'Resurrection', {holy:4}, 1, nil, 0], 
  ['mw1i23', 'incantation', 'Rouse the Beast', {nature:1}, 2, nil, 1],
  ['mw1i24', 'incantation', 'Seeking Dispel', {arcane:1}, 3, 2, 1],
  ['mw1i25', 'incantation', 'Shift Enchantment', {arcane:1}, 2, nil, 2, {novice:true}],
  ['mw1i26', 'incantation', 'Sleep', {mind:2}, 2, nil, 1],
  ['mw1i27', 'incantation', 'Steal Enchantment', {arcane:3}, 2, nil, 1],
  ['mw1i28', 'incantation', 'Teleport', {arcane:2}, 3, nil, 2],
  ['mw1i29', 'incantation', 'Vampiric Strike', {dark:1}, 2, 3, 1]
].each { |p| create_card(*p)} 

# Creature
[
  ['mw1c01', 'creature', 'Adramelech, Lord of Fire', {dark:4, fire:2}, 1, 24, 0],
  ['mw1c02', 'creature', 'Asyran Cleric', {holy:1}, 4, 5, 1],
  ['mw1c03', 'creature', 'Dark Pact Slayer', {dark:3}, 2, 13, 1],
  ['mw1c04', 'creature', 'Bitterwood Fox', {nature:1}, 4, 5, 1],
  ['mw1c05', 'creature', 'Blue Gremlin', {arcane:2}, 2, 7, 1],
  ['mw1c06', 'creature', 'Brogan Bloodstone', {holy:4}, 1, 15, 0],
  ['mw1c07', 'creature', 'Cervere, The Forest Shadow', {nature:4}, 1, 15, 0],
  ['mw1c08', 'creature', 'Darkfenne Bat', {dark:1}, 3, 5, 1],
  ['mw1c09', 'creature', 'Darkfenne Hydra', {arcane:4}, 2, 16, 0],
  ['mw1c12', 'creature', 'Emerald Tegu', {nature:2}, 2, 9, 0],
  ['mw1c13', 'creature', 'Fellella, Pixie Familiar', {nature:3}, 1, 12, 0],
  ['mw1c14', 'creature', 'Feral Bobcat', {nature:1}, 2, 5, 1],
  ['mw1c15', 'creature', 'Firebrand Imp', {dark:1}, 3, 5, 1],
  ['mw1c16', 'creature', 'Flaming Hellion', {dark:3}, 2, 13, 1],
  ['mw1c17', 'creature', 'Goran, Werewolf Pet', {dark:4}, 1, 15, 0],
  ['mw1c18', 'creature', 'Gorgon Archer', {arcane:4}, 1, 16, 0],
  ['mw1c19', 'creature', 'Gray Angel', {holy:3}, 2, 12, 1],
  ['mw1c20', 'creature', 'Highland Unicorn', {holy:3}, 2, 13, 0],
  ['mw1c21', 'creature', 'Huginn, Raven Familiar', {arcane:3}, 1, 11, 0],
  ['mw1c22', 'creature', 'Knight of Westlock', {holy:3}, 2, 13, 0],
  ['mw1c23', 'creature', 'Malacoda', {dark:4}, 1, 16, 0],
  ['mw1c24', 'creature', 'Mana Leech', {arcane:2}, 3, 8, 1],
  ['mw1c25', 'creature', 'Mountain Gorilla', {nature:4}, 1, 16, 1],
  ['mw1c26', 'creature', 'Necropian Vampiress', {dark:4}, 1, 16, 1],
  ['mw1c27', 'creature', 'Moonglow Faerie', {arcane:2}, 2, 8, 1],
  ['mw1c28', 'creature', 'Royal Archer', {holy:3}, 2, 12, 1],
  ['mw1c29', 'creature', 'Redclaw, Alpha Male', {nature:4}, 1, 16, 0],
  ['mw1c31', 'creature', 'Samandriel, Angel of Light', {holy:5}, 1, 21, 0],
  ['mw1c32', 'creature', 'Skeletal Sentry', {dark:2}, 2, 8, 1],
  ['mw1c33', 'creature', 'Sosruko, Ferret Companion', {nature:2}, 1, 7, 0],
  ['mw1c34', 'creature', 'Steelclaw Grizzly', {nature:4}, 1, 17, 0],
  ['mw1c35', 'creature', 'Stonegaze Basilisk', {arcane:3}, 1, 12, 0],
  ['mw1c36', 'creature', 'Tarok, the Skyhunder', {nature:3}, 1, 13, 0],
  ['mw1c37', 'creature', 'Thunderift Falcon', {nature:1}, 2, 6, 1],
  ['mw1c38', 'creature', 'Timber Wolf', {nature:2}, 3, 9, 1],
  ['mw1c39', 'creature', 'Valshalla, Lightning Angel', {holy:5}, 1, 21, 0],
  ['mw1c40', 'creature', 'Whirling Spirit', {air:4}, 1, 12, 1]
].each { |p| create_card(*p)} 


# Equipment
[
  ['mw1q01', 'equipment', 'Arcane Ring', {arcane:1}, 1, 2, 0],
  ['mw1q02', 'equipment', 'Bearskin', {nature:1}, 1, 6, 0],
  ['mw1q03', 'equipment', 'Crown of Protection', {holy:1}, 1, 1, 0],
  ['mw1q04', 'equipment', 'Deflection Bracers', {war:1}, 1, 6, 1],
  ['mw1q05', 'equipment', 'Demonhide Armor', {dark:2}, 1, 8, 0],
  ['mw1q06', 'equipment', 'Dragonscale Hauberk', {fire:1}, 1, 6, 1],
  ['mw1q27', 'equipment', 'Dawnbreaker Ring', {holy:1}, 1, 3, 0],
  ['mw1q07', 'equipment', 'Elemental Cloak', {arcane:1}, 2, 6, 0],
  ['mw1q08', 'equipment', 'Elemental Wand', {earth:2, water:2, air:2, fire:2}, 2, 5, 1, {or_cost:true}],
  ['mw1q09', 'equipment', "Enchanter's Ring", {arcane:1, nature:1}, 1, 2, 0, {or_cost:true}],
  ['mw1q10', 'equipment', 'Fireshaper Ring', {fire:1}, 1, 3, 0],
  ['mw1q11', 'equipment', 'Gauntlets of Strength', {war:1}, 1, 3, 1],
  ['mw1q12', 'equipment', 'Helm of Fear', {dark:2}, 1, 8, 0],
  ['mw1q13', 'equipment', 'Ivarium Longbow', {war:2}, 1, 8, 1],
  ['mw1q14', 'equipment', 'Lash of Hellfire', {dark:1, fire:1}, 1, 8, 0],
  ['mw1q15', 'equipment', 'Leather Boots', {war:1}, 1, 2, 1, {novice:true}],
  ['mw1q16', 'equipment', 'Leather Gloves', {war:1}, 1, 2, 1, {novice:true}],
  ['mw1q17', 'equipment', 'Lightning Ring', {air:1}, 1, 3, 0],
  ['mw1q18', 'equipment', 'Mage Staff', {arcane:1}, 1, 5, 1],
  ['mw1q19', 'equipment', 'Mage Wand', {arcane:2}, 3, 5, 1],
  ['mw1q21', 'equipment', "Moloch's Torment", {dark:1}, 1, 3, 0],
  ['mw1q22', 'equipment', 'Moonglow Amulet', {arcane:1}, 2, 6, 0],
  ['mw1q23', 'equipment', 'Regrowth Belt', {nature:1}, 1, 6, 1],
  ['mw1q24', 'equipment', 'Ring of Asyra', {holy:1}, 1, 2, 0],
  ['mw1q25', 'equipment', 'Ring of Beasts', {nature:1}, 1, 2, 0],
  ['mw1q28', 'equipment', 'Ring of Curses', {dark:1}, 1, 2, 0],
  ['mw1q29', 'equipment', 'Staff of Asyra', {holy:2}, 1, 9, 0],
  ['mw1q30', 'equipment', 'Staff of Beasts', {nature:2}, 1, 7, 0],
  ['mw1q31', 'equipment', 'Staff of the Arcanum', {arcane:2}, 1, 8, 0],
  ['mw1q32', 'equipment', 'Suppression Cloak', {arcane:2}, 1, 8, 0],
  ['mw1q33', 'equipment', 'Wind Wyvern Hide', {air:1}, 1, 6, 0]
].each { |p| create_card(*p)} 

# Conjuration
[
  ['mw1j01', 'conjuration', "Rajan's Fury", {nature:2}, 1, 7, 1],
  ['mw1j02', 'conjuration', 'Animal Kinship', {nature:2}, 1, 8, 1],
  ['mw1j03', 'conjuration', 'Tooth & Nail', {nature:2}, 1, 7, 1],
  ['mw1j04', 'conjuration', 'Battle Forge', {war:1, fire:1}, 2, 8, 1],
  ['mw1j06', 'conjuration', 'Gate to Hell', {dark:6}, 1, 12, 0, {deck_max:1}],
  ['mw1j07', 'conjuration', 'Gate to Voltari', {arcane:4}, 1, 14, 0, {deck_max:1}],
  ['mw1j08', 'conjuration', 'Hand of Bim-Shalla', {holy:1}, 1, 5, 1],
  ['mw1j09', 'conjuration', 'Temple of the Dawnbreaker', {holy:2}, 1, 8, 1],
  ['mw1j10', 'conjuration', 'Lair', {nature:4}, 1, 15, 0, {deck_max:1}],
  ['mw1j11', 'conjuration', 'Idol of Pestilence', {dark:2}, 1, 9, 0, {deck_max:1}],
  ['mw1j12', 'conjuration', 'Mana Crystal', {arcane:1}, 5, 5, 1],
  ['mw1j13', 'conjuration', 'Mana Flower', {nature:1}, 5, 5, 1],
  ['mw1j14', 'conjuration', 'Mana Siphon', {arcane:3}, 1, 12, 0, {deck_max:1}],
  ['mw1j15', 'conjuration', 'Mohktari, Great Tree of Life', {nature:2}, 1, 8, 0],
  ['mw1j16', 'conjuration', "Mordok's Obelisk", {arcane:2}, 1, 8, 0, {deck_max:1}],
  ['mw1j17', 'conjuration', 'Pentagram', {dark:4}, 1, 14, 0, {deck_max:1}],
  ['mw1j18', 'conjuration', 'Poison Gas Cloud', {air:2}, 2, 8, 0],
  ['mw1j19', 'conjuration', 'Deathlock', {dark:2}, 1, 9, 0, {deck_max:1}],
  ['mw1j20', 'conjuration', 'Sacrificial Altar', {dark:1}, 1, 4, 0],
  ['mw1j21', 'conjuration', 'Supression Orb', {mind:2}, 1, 8, 0, {deck_max:1}],
  ['mw1j22', 'conjuration', 'Tanglevine', {nature:1}, 3, 5, 1],
  ['mw1j23', 'conjuration', 'Temple of Asyra', {holy:3}, 1, 10, 0, {deck_max:1}],
  ['mw1j24', 'conjuration', 'Temple of Light', {holy:2}, 1, 9, 0],
  ['mw1w01', 'conjuration', 'Fog Bank', {air:1}, 2, 4, 1],
  ['mw1w02', 'conjuration', 'Wall of Stone', {earth:2}, 2, 7, 1],
  ['mw1w03', 'conjuration', 'Wall of Fire',  {fire:2}, 2, 7, 1],
  ['mw1w04', 'conjuration', 'Wall of Thorns', {nature:1}, 2, 5, 1]
].each { |p| create_card(*p)} 
