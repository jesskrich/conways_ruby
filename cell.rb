class Cell
	attr_accessor :alive, :x, :y, :cell, :board, :alive_next
	def initialize(y=0, x=0)
		@x = x
		@y = y
		@alive = [true, false].sample
		# @dead = dead
		@alive_next = nil
	end

	def alive?
		alive
	end

	def dead?
		!alive
	end

	def alive_next?
		alive_next
	end

	def destruct!
		@alive = false
	end

	def resurrect!
		@alive = true
	end

end

