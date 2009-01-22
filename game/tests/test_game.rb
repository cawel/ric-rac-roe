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

	context 'Before the game begins' do

		before do
			@game = Game.new
		end

		test "should be player with crosses as first_player" do
			assert_equal(@game.current_player, Grid::CROSS)
		end

		test "all squares in matrix should be nil" do
			@game.squares.each {|row| assert row.compact.empty?}
		end

	end


	context 'During the course of the game' do

		before do
			@game = Game.new
			@mockGameplay = MockGameplay.new
		end

		test "should toggle player after a move" do
			@mockGameplay.position = Position.new(0,0)
			@game.play @mockGameplay
			assert_equal(@game.current_player, Grid::NAUGHT)

			@mockGameplay.position = Position.new(1,0)
			@game.play @mockGameplay
			assert_equal(@game.current_player, Grid::CROSS)
		end

		test "should modify squares matrix after move" do
			@mockGameplay.position = Position.new(0,0)
			@game.play @mockGameplay
			assert_equal('X', @game.squares[0][0])
		end

	end

end
