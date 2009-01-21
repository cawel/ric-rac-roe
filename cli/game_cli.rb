require File.join(File.dirname(__FILE__), '..', 'game', 'game.rb')

class GameCli

	attr_accessor :squares
	attr_accessor :status_message

	def initialize
		@game = Game.new
		@squares = @game.squares
	end

	def start
		print_intro
		@game.run_until_over(self)
		print_finish
	end

	def position
		Position.parse gets
	end

	#methods for displaying stuff on the command line
	def display
		puts ""
		puts squares_as_string
		puts status_message if status_message
	end

	def squares_as_string
		string = ""
		@squares.each do |row|
			row.each do |player|
				string += "| #{player.nil? ? ' ': player} "
			end
			string += "|\n"
		end
		string
	end

	def print_intro
		puts "Welcome to Ric-Rac-Roe!"
		puts ""
		puts "To play a move, enter the x and y coordinates for a 3x3 grid."
		puts "Example: typing \"0 2\" would play in the first row, 3rd column."
		puts ""
		puts "Let the game begin!"
		puts ""
		display
	end

	def print_finish	
		puts ""
		if @game.winner
			puts "Player with #{@game.winner}'s won!"
		else
			puts "Draw!"
		end
	end
end
