require File.join(File.dirname(__FILE__), '../game/game.rb')

class GameShoes

	attr_accessor :squares
	attr_accessor :position
	attr_accessor :status_message

	def initialize
		@game = Game.new
		@squares = @game.squares
	end

	def play x, y
		@position = Position.new(x.to_i, y.to_i)
		@game.play self
	end

	def winner
		@game.winner
	end

	def over?
		@game.over?
	end

end
