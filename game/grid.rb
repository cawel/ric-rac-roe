require File.join(File.dirname(__FILE__), 'array_extensions.rb')
require File.join(File.dirname(__FILE__), 'outside_grid_error.rb')
require File.join(File.dirname(__FILE__), 'square_already_taken_error.rb')
require File.join(File.dirname(__FILE__), 'position.rb')

class Grid
	NAUGHT = 'O'
	CROSS = 'X'

	attr_reader :winner
	attr_reader :squares

	def initialize
		# 3 x 3 grid with nils inside
		@squares = []
		3.times { @squares << Array.new(3)}
	end

	def play position, player
		raise ArgumentError, "invalid player handle." unless (player == NAUGHT) || (player == CROSS)
		raise OutsideGridError, "square (#{position.x}, #{position.y}) is outside grid." unless (inside_grid? position.x and inside_grid? position.y)
		raise SquareAlreadyTakenError, "square (#{position.x}, #{position.y}) is already taken." if squares(position.x, position.y)
		@squares[position.y][position.x] = player
		@winner = player if has_a_winner?
	end

	def squares(x = nil, y = nil)
		return @squares if x.nil? and y.nil?
		@squares[y][x]
	end

	def has_a_winner?
		horizontal_win? || vertical_win? || diagonal_win?
	end

	def over?
		has_a_winner? || is_full?
	end

	def is_full?
		@squares.each do |row|
			row.each do |square|
				return false unless square == NAUGHT || square == CROSS
			end
		end
		true
	end

	private
	def inside_grid? p
		(0..2).include? p
	end

	def vertical_win?
		(0..2).each do |column|
			return true if [@squares[0][column], @squares[1][column], @squares[2][column]].common_element 
		end
		false
	end

	def horizontal_win?
		@squares.each do |row|
			return true if row.common_element
		end
		false
	end

	def diagonal_win?
		return true if [@squares[0][0], @squares[1][1], @squares[2][2]].common_element
		return true if [@squares[2][0], @squares[1][1], @squares[0][2]].common_element
		false
	end

end
