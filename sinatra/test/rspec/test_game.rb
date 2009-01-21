require 'rubygems'
require 'sinatra'
require 'sinatra/test/rspec'
require File.join(File.dirname(__FILE__), '../../server.rb')

Dir.chdir('../../')

describe 'Game logic' do

	before(:each) do
		#needed so that the Sinatra's session middleware does not overwrite 
		#my session data (using 'rack.session') in my test
		disable :sessions 

		@session_game = GameSinatra.new
	end

	it 'should be able to play in 0,0' do
		puts @session_game
		post '/play', {:x => 0, :y => 0}, 'rack.session' => { :game => @session_game }
		@response.should be_ok
	end
end
