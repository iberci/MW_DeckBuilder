require 'spec_helper'

describe 'card scopes' do
  it 'only retrieves cards with type "Enchantment" when scoped on enchantment' do
    expect(Card.for_type('Enchantment').map(&:type_name).uniq.first).to eq('Enchantment')
  end

  it 'retrieves multiple types when scoped on multiple types' do 
    types = %w{Enchantment Equipment}
    expect(Card.for_type(types).map(&:type_name).uniq.size).to eq(types.size)
  end

  it 'retrieves cards belonging to a specific school' do 
    expect(Card.for_school('Holy').size).to eq(SchoolLevel.where(:school_name => 'Holy').size)
  end

  it 'retrieves cards from multiple schools' do
    schools = %w{Holy Dark}
    expect(Card.for_schools(schools).includes(:school_levels).map(&:school_levels).flatten.map(&:school_name).uniq.size).to be >= (schools.size)
  end
end
