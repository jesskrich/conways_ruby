require 'gosu'
require_relative 'board'

class GameWindow < Gosu::Window
	def initialize(height = 1800, width = 900)
		@height = height
    	@width = width
    	super height, width, false
		self.caption = 'Jessies Game of Life!'


		@background = Gosu::Color.new(0xffdedede)
		@alive = Gosu::Color.new(0xff121212)
		@dead = Gosu::Color.new(0xffededed)

		@rows = height/10
		@cols = width/10
    	@world = Board.new(@rows, @cols)
    	@row_height = height/@rows
    	@col_width = width/@cols
    	@world.populate_board
	end

	def update
		@world.get_neighbors
		@world.flip!
	end

	def draw
		@world.board.each do |row|
			row.each do |cell|
				if cell.alive?
				draw_quad(cell.y * @col_width, cell.x * @row_height, @alive,
					cell.y * @col_width + (@col_width - 1), cell.x * @row_height, @alive,
					cell.y * @col_width + (@col_width - 1), cell.x * @row_height + (@row_height - 1), @alive,
					cell.y * @col_width, cell.x * @row_height + (@row_height - 1), @alive)
				else
				draw_quad(cell.y * @col_width, cell.x * @row_height, @dead,
					cell.y * @col_width + (@col_width - 1), cell.x * @row_height, @dead,
					cell.y * @col_width + (@col_width - 1), cell.x * @row_height + (@row_height - 1), @dead,
					cell.y * @col_width, cell.x * @row_height + (@row_height - 1), @dead)
				end
			end
		end
	end

	def button_down(id)
		case id
		when Gosu::KbSpace
			@world.populate_board
		when Gosu::KbEscape
			close
		end
	end

	def needs_cursor?
		true
	end

	def draw_background
		draw_quad(0, 0, @background,
			width, 0, @background,
			width, height, @background,
			0, height, @background)
	end

end

GameWindow.new.show



window = MyWindow.new
window.show