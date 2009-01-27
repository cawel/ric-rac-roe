require File.join(File.dirname(__FILE__), '../../server.rb')
require 'rubygems'
require 'sinatra/test/rspec'
require File.join(File.dirname(__FILE__), '../helpers/view_helper.rb')

# Testing all routes (aka 'ping controllers' tests)
# as well as some view output

describe 'The Ric-Rac-Roe routes' do

	before(:each) do
		# needed so that the Sinatra's session middleware does not overwrite 
		# my session data (using 'rack.session') in my test
		disable :sessions 

		@session_game = GameSinatra.new
		empty_grid = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
		@session_game.stub!(:squares).and_return(empty_grid)
	end

	it 'should GET /' do
		get '/'
		@response.should be_ok
	end

	it 'should GET /new' do
		get '/new'
		@response.should be_ok
		assert_9_squares_in_view
	end

	it 'should POST /play' do
		post '/play', {:x => 0, :y => 0}, 'rack.session' => { :game => @session_game }
		@response.should be_ok
		assert_9_squares_in_view
	end

	it 'should GET /over' do
		get '/over', {}, 'rack.session' => { :game => @session_game }
		@response.should be_ok
		assert_9_squares_in_view
	end

	it 'should GET /about' do
		get '/about'
		@response.should be_ok
	end

	after(:each) do
		assert_header_in_view
		assert_footer_in_view
	end


	#
	# helper methods
	#

	def assert_header_in_view
		assert !elements("//div[@class='header']").nil?
	end

	def assert_footer_in_view
		assert !elements("//div[@class='footer']").nil?
		assert elements("//div[@class='footer']").text.match(/powered by Sinatra/)
	end

	def assert_9_squares_in_view 
		assert_equal 9, elements("//td").size
	end

end
