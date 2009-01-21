require 'test/unit'
require File.join(File.dirname(__FILE__), '../game.rb')


class MockGameplay
	attr_accessor :squares
	attr_accessor :status_message
	attr_accessor :position
end

class TestGame < Test::Unit::TestCase

	def setup
		@game = Game.new
	end

	def test_should_be_player_with_crosses_as_first_player
		assert_equal(@game.current_player, Grid::CROSS)
	end

	def test_should_toggle_player_after_playing
		mockGameplay = MockGameplay.new
		mockGameplay.position = Position.new(0,0)
		@game.play mockGameplay
		assert_equal(@game.current_player, Grid::NAUGHT)

		mockGameplay.position = Position.new(1,0)
		@game.play mockGameplay
		assert_equal(@game.current_player, Grid::CROSS)
	end
end
