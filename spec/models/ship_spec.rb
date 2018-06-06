require 'rails_helper'

describe Ship do
  it 'requires a name and capacity' do
    ship = Ship.new(ship_name: nil, ship_capacity: nil)
    expect(ship).to be_invalid
  end

  it 'accepts valid name and capacity' do
    ship = Ship.new(ship_name: 'name', ship_capacity: 1)
    expect(ship).to be_valid
  end

  it 'requires capacity of at least 1' do
    ship = Ship.new(ship_name: 'name', ship_capacity: 0)
    expect(ship).to be_invalid
  end

  it 'requires capacity to be an integer' do
    ship = Ship.new(ship_name: 'name', ship_capacity: 0.5)
    expect(ship).to be_invalid
  end
end
