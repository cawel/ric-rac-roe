require File.join(File.dirname(__FILE__), 'position.rb')
require File.join(File.dirname(__FILE__), 'grid.rb')

# There are 2 strategies for using this tic-tac-toe game:
#
# Game#run_until_later 
#   which takes care of all moves in the game
#
# Game#play
#   which plays a single move in the game

class Game

	attr_reader :current_player

	END_TURN_MSG = "Waiting for player with '%s' to play..."

	def initialize
		@grid = Grid.new
		@current_player = Grid::CROSS
	end

	def run_until_over(gameplay)
		until @grid.over?
			play(gameplay)
			gameplay.display
		end
	end

	def play gameplay
		begin
			handle_turn(gameplay.position)
			gameplay.status_message = (END_TURN_MSG % @current_player)
			gameplay.squares = squares
		rescue 
			gameplay.status_message = ($!.message + " " + (END_TURN_MSG % @current_player))
		end
	end

	def squares
		@grid.squares
	end

	def winner
		@grid.winner
	end

	def over?
		@grid.over?
	end
	
	private
	def handle_turn position 
		@grid.play(position, @current_player)
		toggle_player
	end

	def toggle_player
		@current_player = (@current_player == Grid::CROSS) ? (Grid::NAUGHT) : (Grid::CROSS)
	end

end
