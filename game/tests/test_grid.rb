require 'test/unit'
require File.join(File.dirname(__FILE__), '../grid.rb')

class TestGrid < Test::Unit::TestCase

	def setup
		@grid = Grid.new
	end

	def test_should_fill_square_with_0_when_player_with_naughts_plays
		@grid.play(Position.new(0,0), Grid::NAUGHT)
		assert_equal(Grid::NAUGHT, @grid.squares(0,0))
		assert_empty_grid_except_for 0, 0
	end

	def test_should_fill_square_with_X_when_player_with_crosses_plays
		@grid.play(Position.new(1,1), Grid::CROSS)
		assert_equal(Grid::CROSS, @grid.squares(1,1))
		assert_empty_grid_except_for 1, 1
	end

	def test_should_raise_when_player_is_invalid
		assert_raise(ArgumentError){@grid.play(Position.new(0,0), 'invalid player')}
	end

	def test_should_raise_when_square_is_outside_grid
		assert_raise(Grid::OutsideGridError){@grid.play(Position.new(3,0), Grid::NAUGHT)}
	end

	def test_should_raise_when_square_is_already_taken
		@grid.play(Position.new(0,0), Grid::NAUGHT)
		assert_raise(Grid::SquareAlreadyTakenError){@grid.play(Position.new(0,0), Grid::NAUGHT)}
	end

	def test_should_detect_when_a_grid_is_full
		assert !@grid.is_full?

		(0..2).each do |x|
			(0..2).each do |y|
				@grid.play(Position.new(x,y), Grid::NAUGHT)
			end
		end

		assert @grid.is_full?
	end

	def test_should_win_horizontally
		assert !@grid.has_a_winner?
		play_horizontal_winning_moves_for(Grid::CROSS)
		assert @grid.has_a_winner?
	end

	def test_should_recognize_a_vertical_win
		assert !@grid.has_a_winner?
		play_vertical_winning_moves_for(Grid::CROSS)
		assert @grid.has_a_winner?
	end

	def test_should_recognize_a_diagonal_win
		assert !@grid.has_a_winner?
		play_diagonal_winning_moves_for(Grid::CROSS)
		assert @grid.has_a_winner?
	end

	def test_should_fetch_winning_player_with_crosses
		assert_equal(@grid.winner, nil)
		play_horizontal_winning_moves_for(Grid::CROSS)
		assert @grid.has_a_winner?
		assert_equal(Grid::CROSS, @grid.winner)
	end

	def test_should_fetch_winning_player_with_naughts
		assert_equal(@grid.winner, nil)
		play_horizontal_winning_moves_for(Grid::NAUGHT)
		assert @grid.has_a_winner?
		assert_equal(Grid::NAUGHT, @grid.winner)
	end
	
  #helper methods
	def assert_empty_grid_except_for posx, posy
		(0..2).each do |x|
			(0..2).each do |y|
				next if x == posx and y == posy
				fail "square (#{x},#{y}) should be empty" unless @grid.squares(x, y).nil?
			end
		end
	end

	def play_vertical_winning_moves_for player
		@grid.play(Position.new(0,0), player)
		@grid.play(Position.new(0,1), player)
		@grid.play(Position.new(0,2), player)
	end

	def play_horizontal_winning_moves_for player
		@grid.play(Position.new(0,0), player)
		@grid.play(Position.new(1,0), player)
		@grid.play(Position.new(2,0), player)
	end
	
	def play_diagonal_winning_moves_for player
		@grid.play(Position.new(0,0), player)
		@grid.play(Position.new(1,1), player)
		@grid.play(Position.new(2,2), player)
	end
end
