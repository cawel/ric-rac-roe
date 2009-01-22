require 'rubygems'
require 'sinatra'
require 'sinatra/test/rspec'
require File.join(File.dirname(__FILE__), '../../server.rb')

Dir.chdir "../../"

describe 'The Ric-Rac-Roe routes' do

	before(:each) do
		#needed so that the Sinatra's session middleware does not overwrite 
		#my session data (using 'rack.session') in my test
		disable :sessions 

		@session_game = GameSinatra.new
		@session_game.stub!(:squares).and_return([])
	end

	it 'should GET /' do
		get '/'
		@response.should be_ok
	end

	it 'should GET /new' do
		get '/new'
		@response.should be_ok
	end

	it 'should POST /play' do
		post '/play', {:x => 0, :y => 0}, 'rack.session' => { :game => @session_game }
		@response.should be_ok
	end

	it 'should GET /over' do
		get '/over', {}, 'rack.session' => { :game => @session_game }
		@response.should be_ok
	end

	it 'should GET /about' do
		get '/about'
		@response.should be_ok
	end

end
