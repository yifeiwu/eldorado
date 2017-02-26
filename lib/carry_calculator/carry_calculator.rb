class CarryCalculator

	CarryContainer = Struct.new(:name, :capacity)
	Response = Struct.new(:success?, :message)

	def initialize()
		@containers = []
		@lookup_table = {}
	end

	def add_container(name, capacity)
		return Response.new(false,"invalid container") if !valid?(name,capacity)
		@containers << CarryContainer.new(name, capacity)
		Response.new(true,"#{name} container added with capacity #{capacity}")
	end

	def preprocess
		return Response.new(false, "no containers to process") if @containers == []
		generate_lookup_hash
		Response.new(true, "preprocessed")
	end

	def get_manifest(total_weight)
		@lookup_table["#{total_weight}"]
	end


	private

	def generate_lookup_hash(max_size=10)
		cycle_size = @containers.size
		coefs = Array.new(cycle_size, 0)
		weights = @containers.collect{|container| container.capacity}


		while true do 
			coefs = cycle_coefficients(coefs, max_size)
			return if coefs == false #last iteration
			total_weight = dot_product(coefs, weights)
			num_cons = coefs.inject(:+) 

			fill_lookup_table(total_weight, coefs, num_cons)  
		end
	end


	def cycle_coefficients(coefs,max_size)
		return false if coefs.last == max_size 
		carryover = coefs.index{|x| x == max_size}
		if carryover
			coefs.fill(0, 0..carryover)
			coefs[carryover+1] += 1
			return coefs
		else
			add_digit = coefs.index{|x| x != max_size}
			coefs[add_digit] += 1
			return coefs
		end
	end


	def dot_product(a1,a2)
		a1.each_with_index.inject(0) do |sum, element| 
			multiplicand, index = element
			sum += multiplicand * a2[index]
		end
	end

	def fill_lookup_table(total_weight, coefs, num_cons)
		if @lookup_table["#{total_weight}"].nil?
	    @lookup_table["#{total_weight}"] = coefs.dup
		else 
			better_set = num_cons < @lookup_table["#{total_weight}"].inject(:+)
			@lookup_table["#{total_weight}"] = coefs.dup if better_set
		end
	end

	def valid?(name, capacity)
		return false if name.nil? || capacity.nil?
		return false if !(capacity.is_a? Integer)
		return false if capacity <= 0
		return true
	end

end