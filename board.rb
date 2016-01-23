require 'pry'
require_relative 'cell'

class Board
	attr_accessor :board, :rows, :cols
	def initialize(rows=80, cols=80)
		@rows = rows
		@cols = cols
		@board = board
	end

	def populate_board
		@board = Array.new(rows) do |row|
			Array.new(cols) do |col|
				Cell.new(col, row)
			end
		end
	end
	

	def get_neighbors
		board.each do |row|
			row.each do |cell|
				neighbors = [[cell.x-1, cell.y-1], [cell.x-1, cell.y], [cell.x-1, cell.y+1], [cell.x, cell.y-1], [cell.x, cell.y+1], [cell.x+1, cell.y-1], [cell.x+1, cell.y], [cell.x+1, cell.y+1]]
				neighbors.reject! {|coordinate| coordinate[0] < 0 || coordinate[1] < 0 || coordinate[0] > 79 || coordinate[1] > 79 }
				check_cell_status(neighbors, cell)
			end
		end
	end

		def check_cell_status(neighbors, cell)
			live_cells = []
			neighbors.each do |coordinate| 
				if @board[coordinate[0]][coordinate[1]].alive?
					live_cells << @board[coordinate[0]][coordinate[1]]
				end
			end
			change_status(live_cells.count, cell)
		end
	
	def change_status(live_cells, cell)
		if cell.alive? == true && live_cells > 3 || live_cells < 2
		 		cell.alive_next = false

		end

		if cell.alive? && live_cells == 2 || live_cells == 3
			cell.alive_next = true
		end

		if cell.dead? == true && live_cells == 3
		 		cell.alive_next = true
		end

		if cell.dead? && live_cells != 3
			cell.alive_next = false
		end
	end

	def flip!
		@board.each do |row|
			row.each do |cell|
				if cell.alive_next == true
				@board[cell.x][cell.y].resurrect!
				else
				@board[cell.x][cell.y].destruct!
				end
			end
		end
	end

end



