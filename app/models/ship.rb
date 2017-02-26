class Ship < ApplicationRecord
	def self.ship_names 
		Ship.all.collect{|ship| ship.ship_name}
	end

	def self.ship_capacities
		Ship.all.collect{|ship| ship.ship_capacity}
	end

end
