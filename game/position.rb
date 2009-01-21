require File.join(File.dirname(__FILE__), 'parsing_error.rb')

class Position

	attr_accessor :x, :y

	def initialize(x, y)
		@x, @y = x, y
	end

	def self.parse(digits)
		new(*digits.scan(/(\d).*(\d)/).flatten.map{|d| d.to_i})
	rescue 
		raise ParsingError, "invalid input! Please enter 2 coordinates. Example: \"2 0\". " 
	end

	def inspect
		"<Position x:#{x}, y:#{y}>"
	end

end
