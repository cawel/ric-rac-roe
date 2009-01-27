require 'test/unit'
require 'rubygems'
require 'context'
require File.join(File.dirname(__FILE__), '../game.rb')


class MockGameplay
	attr_accessor :squares
	attr_accessor :status_message
	attr_accessor :position
end

class TestGame < Test::Unit::TestCase

	context 'At the beginning of the game' do

		before do
			@game = Game.new
		end

		test "it should be player with crosses as first_player" do
			assert_equal(@game.current_player, Grid::CROSS)
		end

		test "all squares in matrix should be nil" do
			@game.squares.each {|row| assert row.compact.empty?}
		end

		test "there should be no winner" do
			assert_nil @game.winner
		end

		test "it should not be game over" do
			assert !@game.over?
		end

	end


	context 'After a first move in 0,1 has been played' do

		before do
			@game = Game.new
			@mockGameplay = MockGameplay.new
			@mockGameplay.position = Position.new(0,1)
			@game.play @mockGameplay
		end

		test "it should toggle player to NAUGHT" do
			assert_equal(@game.current_player, Grid::NAUGHT)
		end

		test "it should put an 'X' in squares[1][0]" do
			assert_equal('X', @game.squares[1][0])
		end

		context "and after a second move in 2,2" do
			before do
				@mockGameplay.position = Position.new(2,2)
				@game.play @mockGameplay
			end

			test "it should toggle player to CROSS" do
				assert_equal(@game.current_player, Grid::CROSS)
			end

			test "it should put an 'O' in squares[2][2]" do
				assert_equal('O', @game.squares[2][2])
			end

		end
	end

	context 'A series of moves leading to a winning position for X' do

		before do
			# winning position for x:
			#  x|x|x
			#  o|o|
			#   | |
			@game = Game.new
			@mockGameplay = MockGameplay.new
			@mockGameplay.position = Position.new(0,0)
			@game.play @mockGameplay
			@mockGameplay.position = Position.new(0,1)
			@game.play @mockGameplay
			@mockGameplay.position = Position.new(1,0)
			@game.play @mockGameplay
			@mockGameplay.position = Position.new(1,1)
			@game.play @mockGameplay
			@mockGameplay.position = Position.new(2,0)
			@game.play @mockGameplay
		end

		test "it should detect the game is over" do
			assert(@game.over?)
		end

		test "it should detect that X is the winner" do
			assert_equal(Grid::CROSS, @game.winner)
		end

	end

end
