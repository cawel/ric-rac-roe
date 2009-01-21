require 'test/unit'
require File.join(File.dirname(__FILE__), '../position.rb')

class TestPosition < Test::Unit::TestCase

	def test_should_parse_valid_coma_separated_coords_and_set_position_coords
		position = nil
		assert_nothing_raised(Exception){ position = Position.parse('0,2') }
		assert_equal(0, position.x)
		assert_equal(2, position.y)
	end

	def test_should_parse_valid_consecutive_coords_and_set_position_coords
		position = nil
		assert_nothing_raised(Exception){ position = Position.parse('12') }
		assert_equal(1, position.x)
		assert_equal(2, position.y)
	end

	def test_should_raise_exception_on_invalid_input
		assert_raise(ParsingError){ Position.parse("abc") }
	end
end
