class Ship < ApplicationRecord
  validates :ship_capacity, numericality: { only_integer: true, greater_than: 0 }
  validates :ship_name, presence: true

  def self.ship_names
    Ship.all.collect(&:ship_name)
  end

  def self.ship_capacities
    Ship.all.collect(&:ship_capacity)
  end
end
