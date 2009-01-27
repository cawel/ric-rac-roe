require 'test/unit'
require 'rubygems'
require 'context'
require File.join(File.dirname(__FILE__), '../array_extensions.rb')

class TestArrayExtensions < Test::Unit::TestCase

	context 'When the array is empty' do
		it "should return nil" do
			assert_nil [].common_element
		end
	end

	context 'When the array contains the same elements' do
		it 'should return this element' do
			assert_equal(1, [1,1,1].common_element)
		end
	end

	context 'When the array does not contain the same elements' do
		it 'should return nil' do
			assert_nil [1,2,3].common_element
		end
	end

end
